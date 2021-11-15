import 'package:json_annotation/json_annotation.dart';

part 'ward_model.g.dart';

@JsonSerializable()
class WardModel {
  String? id;
  String? name;
  String? prefix;

  WardModel({
    this.id,
    this.name,
    this.prefix,
  });

  factory WardModel.fromJson(Map<String, dynamic> json) => _$WardModelFromJson(json);

  Map<String, dynamic> toJson() => _$WardModelToJson(this);
}
