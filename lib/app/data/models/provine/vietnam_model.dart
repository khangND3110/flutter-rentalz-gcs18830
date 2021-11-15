import 'package:json_annotation/json_annotation.dart';

import 'city_model.dart';

part 'vietnam_model.g.dart';

@JsonSerializable()
class VietnamModel {
  List<CityModel>? data;

  VietnamModel({
    this.data,
  });

  factory VietnamModel.fromJson(Map<String, dynamic> json) =>
      _$VietnamModelFromJson(json);

  Map<String, dynamic> toJson() => _$VietnamModelToJson(this);
}
