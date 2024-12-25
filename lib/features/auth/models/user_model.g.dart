// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      className: json['bankAccount'] as String,
      noTelp: json['no_telp'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['type_bank'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'bankAccount': instance.className,
      'no_telp': instance.noTelp,
      'username': instance.username,
      'email': instance.email,
      'type_bank': instance.password,
      'name': instance.name,
    };
