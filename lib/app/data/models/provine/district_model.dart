import 'package:json_annotation/json_annotation.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/provine/ward_model.dart';

part 'district_model.g.dart';

@JsonSerializable()
class DistrictModel {
  String? id;
  String? name;
  List<WardModel>? wards;

  DistrictModel({
    this.id,
    this.name,
    this.wards,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) => _$DistrictModelFromJson(json);

  Map<String, dynamic> toJson() => _$DistrictModelToJson(this);
}
