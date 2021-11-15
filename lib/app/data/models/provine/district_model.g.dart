// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'district_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistrictModel _$DistrictModelFromJson(Map<String, dynamic> json) {
  return DistrictModel(
    id: json['id'] as String?,
    name: json['name'] as String?,
    wards: (json['wards'] as List<dynamic>?)
        ?.map((e) => WardModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DistrictModelToJson(DistrictModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'wards': instance.wards,
    };
