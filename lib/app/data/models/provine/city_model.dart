import 'package:json_annotation/json_annotation.dart';

import 'district_model.dart';

part 'city_model.g.dart';

@JsonSerializable()
class CityModel {
  String? id;
  String? name;
  String? code;
  List<DistrictModel>? districts;

  CityModel({
    this.id,
    this.name,
    this.code,
    this.districts,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);

  Map<String, dynamic> toJson() => _$CityModelToJson(this);
}
