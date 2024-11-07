// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      transactionModelClass: json[r'$class'] as String,
      sender: json['sender'] as String,
      receiver: json['receiver'] as String,
      transactionTime: json['transactionTime'] as String,
      amount: (json['amount'] as num).toInt(),
      status: json['status'] as String,
      transactionId: json['transactionId'] as String,
      timestamp: json['timestamp'] as String,
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      r'$class': instance.transactionModelClass,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'transactionTime': instance.transactionTime,
      'amount': instance.amount,
      'status': instance.status,
      'transactionId': instance.transactionId,
      'timestamp': instance.timestamp,
    };
