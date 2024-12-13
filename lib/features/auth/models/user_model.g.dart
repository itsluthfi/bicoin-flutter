// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      className: json['accountId'] as String,
      noTelp: json['phone'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'accountId': instance.className,
      'phone': instance.noTelp,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
    };
