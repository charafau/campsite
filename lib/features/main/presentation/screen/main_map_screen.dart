import 'package:campsite/features/main/domain/model/group.dart';
import 'package:campsite/features/main/domain/model/group_path.dart';
import 'package:campsite/features/main/domain/usecase/get_group_usecase.dart';
import 'package:campsite/features/main/presentation/bloc/campsite_bloc.dart';
import 'package:campsite/features/main/presentation/bloc/group_bloc.dart';
import 'package:campsite/logic/graph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class MainMapScreen extends StatelessWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Group list'),
          ),
          body: create(),
        );
      },
      settings: RouteSettings(name: '/groupList'),
    );
  }

  static Widget create() {
    return BlocProvider<GroupBloc>(
      create: (BuildContext context) => GroupBloc(
          getGroupsUseCase: context.read<GetGroupsUseCase>(),
          graph: Graph.campsite()),
      child: MapScreen(),
    );
  }

  @override
  Widget build(BuildContext context) => MapScreen();
}

class MapScreen extends StatefulWidget {
  static const groupListKey = Key('__groupList__');

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final groupBloc = context.bloc<GroupBloc>();
    return BlocConsumer<GroupBloc, GroupState>(
      builder: (
        BuildContext context,
        GroupState state,
      ) {
        if (state is GroupLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is GroupsLoaded) {
          return ListView.builder(
              key: MapScreen.groupListKey,
              itemCount: state.groupPaths.length,
              itemBuilder: (context, index) {
                final groupPath = state.groupPaths[index];
                return _Item(
                  groupPath: groupPath,
                );
              });
        }

        return SizedBox();
      },
      listener: (BuildContext context, GroupState state) {
        if (state is GroupsNotLoaded) {
          final snackBar = SnackBar(content: Text("Couldn't download data"));

          Scaffold.of(context).showSnackBar(snackBar);
        }
      },
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    Key key,
    @required this.groupPath,
  }) : super(key: key);

  final GroupPath groupPath;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: (){
          // ignore: close_sinks
          final bloc = context.bloc<CampsiteBloc>();
          bloc.add(ChooseGroup(groupPath));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Group ${groupPath.group.familyid}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.people,
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Text('${groupPath.group.groupsize}'),
                  SizedBox(width: 8),
                  Icon(
                    Icons.airport_shuttle,
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Text('${groupPath.group.caravan}'),
                ],
              ),
              Text('Travel time: ${groupPath.verticesPath.length} min'),
              SizedBox(width: 8),
              Text('Waiting time: ${groupPath.waitingTime} min'),
              SizedBox(width: 8),
              Text('Travel map: ${groupPath.verticesPath.reversed.join(" -> ")}')
            ],
          ),
        ),
      ),
    );
  }
}
