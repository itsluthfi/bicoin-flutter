import 'package:json_annotation/json_annotation.dart';

part 'firebase_user_model.g.dart';

@JsonSerializable()
class FirebaseUserModel {
  @JsonKey(name: "bankAccount")
  final String bankAccount;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "no_telp")
  final String noTelp;
  @JsonKey(name: "email")
  final String email;
  @JsonKey(name: "username")
  final String username;
  @JsonKey(name: "type_bank")
  final String typeBank;

  FirebaseUserModel({
    required this.bankAccount,
    required this.name,
    required this.noTelp,
    required this.email,
    required this.username,
    required this.typeBank,
  });

  factory FirebaseUserModel.fromJson(Map<String, dynamic> json) =>
      _$FirebaseUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$FirebaseUserModelToJson(this);
}
