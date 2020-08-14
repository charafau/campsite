import 'package:bloc/bloc.dart';
import 'package:campsite/features/main/domain/model/group_path.dart';
import 'package:equatable/equatable.dart';

part 'campsite_event.dart';

part 'campsite_state.dart';

class CampsiteBloc extends Bloc<CampsiteEvent, CampsiteState> {
  CampsiteBloc() : super(CampsiteInit());

  @override
  Stream<CampsiteState> mapEventToState(CampsiteEvent event) async* {
    if (event is ChooseGroup) {
      yield GroupSelected(event.groupPath);
    }
  }
}
