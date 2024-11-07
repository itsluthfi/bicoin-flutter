class UserRekening {
  String bankAccount;
  String name;
  String noTelp;
  String email;
  String username;
  String typeBank;

  UserRekening({
    required this.bankAccount,
    required this.name,
    required this.noTelp,
    required this.email,
    required this.username,
    required this.typeBank,
  });

  factory UserRekening.fromJson(Map<String, dynamic> json) {
    return UserRekening(
      bankAccount: json['bankAccount'],
      name: json['name'],
      noTelp: json['no_telp'],
      email: json['email'],
      username: json['username'],
      typeBank: json['type_bank'],
    );
  }

  // Method untuk mengonversi objek User menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'bankAccount': bankAccount,
      'name': name,
      'no_telp': noTelp,
      'email': email,
      'username': username,
      'type_bank': typeBank,
    };
  }
}
