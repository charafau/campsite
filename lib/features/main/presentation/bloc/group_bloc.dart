import 'package:campsite/features/main/domain/model/group.dart';
import 'package:campsite/features/main/domain/model/group_path.dart';
import 'package:campsite/features/main/domain/usecase/get_group_usecase.dart';
import 'package:campsite/logic/graph.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'group_event.dart';

part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final GetGroupsUseCase getGroupsUseCase;
  final Graph graph;

  GroupBloc({
    @required this.graph,
    @required this.getGroupsUseCase,
  }) : super(GroupLoading()) {
    add(LoadGroups());
  }

  @override
  Stream<GroupState> mapEventToState(GroupEvent event) async* {
    if (event is LoadGroups) {
      yield await _fetchGroups();
    }
  }

  Future<GroupState> _fetchGroups() async {
    final groupsEither = await getGroupsUseCase();
    return groupsEither.fold(
      (fail) => GroupsNotLoaded(),
      (data) {
        var tempWaitingTime = 0;
        final paths = data.map((g) {
          final shortestPath = graph.getShortestPath(g.caravan);
          final groupPath = GroupPath(
              group: g,
              verticesPath: shortestPath,
              waitingTime: tempWaitingTime);
          tempWaitingTime = tempWaitingTime + shortestPath.length;
          return groupPath;
        }).toList();
        return GroupsLoaded(paths);
      },
    );
  }
}
