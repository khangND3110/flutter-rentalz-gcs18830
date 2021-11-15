import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? email;
  String? password;
  String? fullName;
  String? phoneNumber;
  String? avatar;

  UserModel({
    this.email,
    this.password,
    this.fullName,
    this.phoneNumber,
    this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
