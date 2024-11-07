// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankAccount _$BankAccountFromJson(Map<String, dynamic> json) => BankAccount(
      username: json['username'] as String,
      bankAccount: json['bankAccount'] as String,
      saldo: json['saldo'] as String,
    );

Map<String, dynamic> _$BankAccountToJson(BankAccount instance) =>
    <String, dynamic>{
      'username': instance.username,
      'bankAccount': instance.bankAccount,
      'saldo': instance.saldo,
    };
