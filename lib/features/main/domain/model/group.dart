import 'package:campsite/features/main/data/dto/group_dto.dart';
import 'package:equatable/equatable.dart';

class Group extends Equatable {
  final int familyid;
  final int groupsize;
  final int caravan;

  Group({this.familyid, this.groupsize, this.caravan});

  @override
  List<Object> get props => [familyid, groupsize, caravan];

  @override
  bool get stringify => true;

  factory Group.fromDto(GroupDto dto) {
    return Group(
        familyid: dto.familyid, groupsize: dto.groupsize, caravan: dto.caravan);
  }

  GroupDto toDto() {
    return GroupDto(
        familyid: this.familyid,
        groupsize: this.groupsize,
        caravan: this.caravan);
  }

  Group copy({
    int familyid,
    int groupsize,
    int caravan,
  }) {
    return Group(
        familyid: familyid ?? this.familyid,
        groupsize: groupsize ?? this.groupsize,
        caravan: caravan ?? this.caravan);
  }
}
