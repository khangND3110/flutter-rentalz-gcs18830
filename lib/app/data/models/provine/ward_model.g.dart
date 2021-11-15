// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ward_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WardModel _$WardModelFromJson(Map<String, dynamic> json) {
  return WardModel(
    id: json['id'] as String?,
    name: json['name'] as String?,
    prefix: json['prefix'] as String?,
  );
}

Map<String, dynamic> _$WardModelToJson(WardModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'prefix': instance.prefix,
    };
