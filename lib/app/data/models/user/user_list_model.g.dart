// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserListModel _$UserListModelFromJson(Map<String, dynamic> json) {
  return UserListModel(
    userList: (json['userList'] as List<dynamic>?)
        ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$UserListModelToJson(UserListModel instance) =>
    <String, dynamic>{
      'userList': instance.userList,
    };
