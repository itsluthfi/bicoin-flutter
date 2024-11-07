import 'package:json_annotation/json_annotation.dart';

part 'user_rekening_model.g.dart';

@JsonSerializable()
class UserRekeningModel {
  @JsonKey(name: 'amount')
  final double? amount;
  @JsonKey(name: 'bankAccount')
  final String? bankAccount;
  @JsonKey(name: 'type_bank')
  final String? typeBank;

  UserRekeningModel({
    this.amount,
    this.bankAccount,
    this.typeBank,
  });

  factory UserRekeningModel.fromJson(Map<String, dynamic> json) =>
      _$UserRekeningModelFromJson(json);
}
