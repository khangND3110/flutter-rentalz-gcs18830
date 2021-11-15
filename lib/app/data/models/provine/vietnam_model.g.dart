// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vietnam_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VietnamModel _$VietnamModelFromJson(Map<String, dynamic> json) {
  return VietnamModel(
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => CityModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$VietnamModelToJson(VietnamModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
