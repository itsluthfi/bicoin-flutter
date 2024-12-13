import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: 'accountId')
  final String className;
  @JsonKey(name: 'phone')
  final String noTelp;
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'password')
  final String password;
  @JsonKey(name: 'name')
  final String name;

  UserModel({
    required this.className,
    required this.noTelp,
    required this.username,
    required this.email,
    required this.password,
    required this.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
