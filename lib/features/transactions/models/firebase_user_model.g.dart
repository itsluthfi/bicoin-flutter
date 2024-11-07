// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirebaseUserModel _$FirebaseUserModelFromJson(Map<String, dynamic> json) =>
    FirebaseUserModel(
      bankAccount: json['bankAccount'] as String,
      name: json['name'] as String,
      noTelp: json['no_telp'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      typeBank: json['type_bank'] as String,
    );

Map<String, dynamic> _$FirebaseUserModelToJson(FirebaseUserModel instance) =>
    <String, dynamic>{
      'bankAccount': instance.bankAccount,
      'name': instance.name,
      'no_telp': instance.noTelp,
      'email': instance.email,
      'username': instance.username,
      'type_bank': instance.typeBank,
    };
