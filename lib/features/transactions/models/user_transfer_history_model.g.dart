// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_transfer_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTransferHistoryModel _$UserTransferHistoryModelFromJson(
        Map<String, dynamic> json) =>
    UserTransferHistoryModel(
      sourceRekening: json['source_rekening'] as String,
      date: json['date'] as String,
      amount: (json['amount'] as num).toDouble(),
      type: json['type'] as String,
      typeBank: json['type_bank'] as String,
      status: json['status'] as String,
      targetRekening: json['target_rekening'] as String,
      adminFee: (json['admin_fee'] as num).toDouble(),
    );

Map<String, dynamic> _$UserTransferHistoryModelToJson(
        UserTransferHistoryModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'amount': instance.amount,
      'type': instance.type,
      'type_bank': instance.typeBank,
      'status': instance.status,
      'source_rekening': instance.sourceRekening,
      'target_rekening': instance.targetRekening,
    };
