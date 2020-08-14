// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupDto _$GroupDtoFromJson(Map<String, dynamic> json) {
  return GroupDto(
    familyid: json['familyid'] as int,
    groupsize: json['groupsize'] as int,
    caravan: json['caravan'] as int,
  );
}

Map<String, dynamic> _$GroupDtoToJson(GroupDto instance) => <String, dynamic>{
      'familyid': instance.familyid,
      'groupsize': instance.groupsize,
      'caravan': instance.caravan,
    };
