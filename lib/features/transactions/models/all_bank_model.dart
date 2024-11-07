import 'package:json_annotation/json_annotation.dart';

part 'all_bank_model.g.dart';

@JsonSerializable()
class AllBankModel {
  @JsonKey(name: '\$class')
  final String className;
  @JsonKey(name: 'no_telp')
  final String noTelp;
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'password')
  final String password;
  @JsonKey(name: 'name')
  final String name;

  AllBankModel({
    required this.className,
    required this.noTelp,
    required this.username,
    required this.email,
    required this.password,
    required this.name,
  });

  factory AllBankModel.fromJson(Map<String, dynamic> json) =>
      _$AllBankModelFromJson(json);

  Map<String, dynamic> toJson() => _$AllBankModelToJson(this);
}
