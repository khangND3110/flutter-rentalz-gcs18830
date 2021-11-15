import 'package:json_annotation/json_annotation.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/user/user_model.dart';

part 'user_list_model.g.dart';

@JsonSerializable()
class UserListModel {
  List<UserModel>? userList;

  UserListModel({
    this.userList,
  });

  factory UserListModel.fromJson(Map<String, dynamic> json) =>
      _$UserListModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserListModelToJson(this);
}
