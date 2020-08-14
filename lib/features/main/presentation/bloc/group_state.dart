part of 'group_bloc.dart';

abstract class GroupState extends Equatable {
  const GroupState();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class GroupInit extends GroupState {}

class GroupLoading extends GroupState {}

class GroupsLoaded extends GroupState {
  final List<GroupPath> groupPaths;

  GroupsLoaded(this.groupPaths);

  @override
  List<Object> get props => [groupPaths];
}

class GroupsNotLoaded extends GroupState {}
