import 'package:campsite/features/main/domain/model/group.dart';
import 'package:equatable/equatable.dart';

class GroupPath extends Equatable {
  final Group group;
  final List<int> verticesPath;
  final int waitingTime;

  GroupPath({this.group, this.verticesPath, this.waitingTime});

  @override
  List<Object> get props => [group, verticesPath];

  @override
  bool get stringify => true;
}
