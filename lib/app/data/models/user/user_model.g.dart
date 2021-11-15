// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    email: json['email'] as String?,
    password: json['password'] as String?,
    fullName: json['fullName'] as String?,
    phoneNumber: json['phoneNumber'] as String?,
    avatar: json['avatar'] as String?,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'avatar': instance.avatar,
    };
