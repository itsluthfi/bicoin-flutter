import 'dart:developer';

import 'package:get/get.dart';

import '../../../core/services/firestore_service.dart';
import '../../../core/services/network_service.dart';
import '../../../core/styles/dev_color.dart';
import '../models/user_rekening_model.dart';
import 'transaction_controller.dart';

class TransactionDifferentBankController extends GetxController {
  FirestoreService firestoreService = FirestoreService();
  var bankList = <String>[].obs;
  var bankUsername = <String>[].obs;
  var bankSelectedUsername = ''.obs;
  final transactionController = Get.put(TransactionController());

  @override
  void onInit() {
    getAllBank();
    super.onInit();
  }

  @override
  void onReady() {
    getAllBank();
    super.onReady();
  }

  Future<void> getAllBank() async {
    try {
      final response = await DioService.instance.getRequest(
        '/org.meetcoin.participant.Merchant',
      );
      var result = response.data as List<dynamic>;
      bankList.value = result.map((e) => e['name'].toString()).toList();
      bankUsername.value = result.map((e) => e['username'].toString()).toList();
    } catch (e) {
      log('Exception occurred: $e');
    }
  }

  Future<void> validationUserByBank({
  required String rekening,
  required String bankTujuan,
  required double amount,
}) async {
  try {
    final response = await firestoreService.getData('bankAccounts', rekening);

    if (!response.exists) {
      log('Rekening tidak ditemukan');
      Get.snackbar(
        'Rekening Tidak Ditemukan',
        'Bank tujuan tidak ditemukan',
        backgroundColor: DevColor.redColor,
        colorText: DevColor.whiteColor,
      );
      return;
    }

    var result = UserRekeningModel.fromJson(
      response.data() as Map<String, dynamic>,
    );

    var typeBankTujuan = result.typeBank;
    int bankIndex = bankList.indexWhere((name) => name == bankTujuan);

    log('Bank tujuan: $typeBankTujuan');

    if (bankIndex == -1) {
      log('Nama bank tidak ada');
      Get.snackbar(
        'Rekening bank salah',
        'Bank tujuan tidak ditemukan',
        backgroundColor: DevColor.redColor,
        colorText: DevColor.whiteColor,
      );
      return;
    }

    bankSelectedUsername.value = bankUsername[bankIndex];
    var currentBankRekening = transactionController.bankAccount.value;

    log('Current Bank Rekening: $currentBankRekening');
    
    // Menghitung 5% dari amount
    double adminFee = amount * 0.05;

    if (bankSelectedUsername.value == typeBankTujuan) {
      // Ketika bank sama, kurangi amount dari rekening sekarang
      await transactionController.debitBankCredit(
        amount,
        rekening,
        'SUCCESS',
        bankSelectedUsername.value,
        adminFee,
      );
      
      // Lalu isikan amount ke rekening tujuan
      await transactionController.fillBankCredit(
        amount,
        typeBankTujuan,
        adminFee: adminFee, // Menggunakan adminFee yang dihitung
        bankAccount: rekening,
      );
      
      // Buat transaksi
      await transactionController.createTransaction(amount);
      log('Transaksi Berhasil');
      await transactionController.loadInitialData();
    }
  } catch (e) {
    log('Error: ${e.toString()}');
  }
}
}
