import 'dart:math';

String generateRandomBankAccountNumber({int length = 16}) {
  final random = Random();
  String accountNumber = '';

  for (int i = 0; i < length; i++) {
    accountNumber += random.nextInt(10).toString();
  }

  return accountNumber;
}
