import 'package:json_annotation/json_annotation.dart';

part 'bank_account.g.dart';

@JsonSerializable()
class BankAccount {
  final String username;
  final String bankAccount;
  final String saldo;

  BankAccount({
    required this.username,
    required this.bankAccount,
    required this.saldo,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) =>
      _$BankAccountFromJson(json);

  Map<String, dynamic> toJson() => _$BankAccountToJson(this);
}
