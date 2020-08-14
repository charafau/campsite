part of 'campsite_bloc.dart';

abstract class CampsiteState extends Equatable {
  const CampsiteState();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class CampsiteInit extends CampsiteState {}

class GroupSelected extends CampsiteState {
  final GroupPath groupPath;

  GroupSelected(this.groupPath);

  @override
  List<Object> get props => [groupPath];
}
