part of 'campsite_bloc.dart';

abstract class CampsiteEvent extends Equatable {
  const CampsiteEvent();

  @override
  List<Object> get props => [];
}

class ChooseGroup extends CampsiteEvent {
  final GroupPath groupPath;

  ChooseGroup(this.groupPath);

  @override
  List<Object> get props => [groupPath];
}
