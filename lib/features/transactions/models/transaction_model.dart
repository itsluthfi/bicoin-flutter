import 'package:json_annotation/json_annotation.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel {
  @JsonKey(name: "\$class")
  final String transactionModelClass;
  @JsonKey(name: "sender")
  final String sender;
  @JsonKey(name: "receiver")
  final String receiver;
  @JsonKey(name: "transactionTime")
  final String transactionTime;
  @JsonKey(name: "amount")
  final int amount;
  @JsonKey(name: "status")
  final String status;
  @JsonKey(name: "transactionId")
  final String transactionId;
  @JsonKey(name: "timestamp")
  final String timestamp;

  TransactionModel({
    required this.transactionModelClass,
    required this.sender,
    required this.receiver,
    required this.transactionTime,
    required this.amount,
    required this.status,
    required this.transactionId,
    required this.timestamp,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}
