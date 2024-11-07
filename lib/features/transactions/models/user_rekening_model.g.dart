// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_rekening_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRekeningModel _$UserRekeningModelFromJson(Map<String, dynamic> json) =>
    UserRekeningModel(
      amount: (json['amount'] as num?)?.toDouble(),
      bankAccount: json['bankAccount'] as String?,
      typeBank: json['type_bank'] as String?,
    );

Map<String, dynamic> _$UserRekeningModelToJson(UserRekeningModel instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'bankAccount': instance.bankAccount,
      'type_bank': instance.typeBank,
    };
