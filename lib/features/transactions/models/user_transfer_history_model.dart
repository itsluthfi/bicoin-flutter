import 'package:json_annotation/json_annotation.dart';

part 'user_transfer_history_model.g.dart';

@JsonSerializable()
class UserTransferHistoryModel {
  @JsonKey(name: "date")
  final String date;
  @JsonKey(name: "amount")
  final double amount;
  @JsonKey(name: "type")
  final String type;
  @JsonKey(name: "type_bank")
  final String typeBank;
  @JsonKey(name: "status")
  final String status;
  @JsonKey(name: "source_rekening")
  final String sourceRekening;
  @JsonKey(name: "target_rekening")
  final String targetRekening;
  @JsonKey(name: "admin_fee")
  final double adminFee;

  UserTransferHistoryModel({
    required this.sourceRekening,
    required this.date,
    required this.amount,
    required this.type,
    required this.typeBank,
    required this.status,
    required this.targetRekening,
    this.adminFee = 0,
  });

  factory UserTransferHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$UserTransferHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserTransferHistoryModelToJson(this);
}
