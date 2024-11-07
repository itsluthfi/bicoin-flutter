// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_bank_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllBankModel _$AllBankModelFromJson(Map<String, dynamic> json) => AllBankModel(
      className: json[r'$class'] as String,
      noTelp: json['no_telp'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$AllBankModelToJson(AllBankModel instance) =>
    <String, dynamic>{
      r'$class': instance.className,
      'no_telp': instance.noTelp,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
    };
