import 'package:json_annotation/json_annotation.dart';

part 'group_dto.g.dart';

@JsonSerializable()
class GroupDto {
  final int familyid;
final int groupsize;
final int caravan;

  GroupDto({this.familyid,this.groupsize,this.caravan});

  factory GroupDto.fromJson(Map<String, dynamic> json) =>
      _$GroupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GroupDtoToJson(this);


  @override
  String toString() {
    return 'GroupDto{familyid: $familyid, groupsize: $groupsize, caravan: $caravan}';
  }
}

    