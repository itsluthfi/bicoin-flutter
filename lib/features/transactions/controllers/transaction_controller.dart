import 'dart:developer';

import 'package:dev_coinku/core/services/fcm_service.dart';
import 'package:dev_coinku/features/transactions/models/firebase_user_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/key_constant.dart';
import '../../../core/services/firestore_service.dart';
import '../../../core/services/network_service.dart';
import '../../dashboard/home/controllers/home_controller.dart';

class TransactionController extends GetxController {
  FirestoreService firestoreService = FirestoreService();
  final homeController = Get.put(HomeController());
  final fcmService = FcmService();
  RxString bankAccount = ''.obs;
  RxString currentBanktype = ''.obs;
  RxDouble saldoAmount = 0.0.obs;
  RxList historyTransferUser = [].obs;
  var userDataFirebase = Rxn<FirebaseUserModel>();
  final box = GetStorage();

  RxString username = ''.obs;
  RxString nominal = ''.obs;

  List getRecentTransactions(int count) {
    // Mengambil 3 transaksi terbaru dari historyTransferUser
    return historyTransferUser.take(count).toList();
  }

  @override
  void onReady() {
    super.onReady();
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    await homeController.getRekeningUser();
    bankAccount.value = homeController.bankAccount.value;
    currentBanktype.value = homeController.currentTypeBank.value;
    await getTransactionHistory();
    saldoAmount.value = await getBankAmount();
  }

  Future<void> fillBankCredit(double amount, String? typeBank,
      {String? bankAccount, double? adminFee}) async {
    var targetBankAccount = bankAccount ?? homeController.bankAccount.value;

    try {
      final bankDoc = await firestoreService.getData(
        'bankAccounts',
        targetBankAccount,
      );

      if (bankDoc.exists) {
        // Mengonversi nilai amount dari Firestore menjadi double
        double currentAmount = (bankDoc['amount'] ?? 0).toDouble();

        double updatedAmount = currentAmount + amount;

        await firestoreService.setData(
          'bankAccounts',
          targetBankAccount,
          {
            'bankAccount': targetBankAccount,
            'amount': updatedAmount,
            'type_bank': typeBank ?? 'coinku'
          },
        );
      } else {
        await firestoreService.setData(
          'bankAccounts',
          targetBankAccount,
          {
            'bankAccount': targetBankAccount,
            'amount': amount,
            'type_bank': typeBank ?? 'coinku'
          },
        );
      }

      await firestoreService.addData(
        'bankAccounts/$targetBankAccount/transactionsHistory',
        {
          'type': 'credit',
          'type_bank': typeBank,
          'status': 'SUCCESS',
          'target_rekening': targetBankAccount,
          'source_rekening': homeController.bankAccount.value,
          'amount': amount,
          'admin_fee': adminFee ?? 0,
          'date': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        },
      );

      var dataNotification = {
        "rekening": targetBankAccount,
        "status": "done",
        "amount": amount.toString(),
        "message":
            "Saldo ${amount.toString()} BIC ditambahkan ke $targetBankAccount",
        "time": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      };

      // Kirim pesan FCM
      fcmService.sendMessage(
        'Saldo $amount BIC berhasil dikirim ke $targetBankAccount',
        dataNotification,
      );
      log('Saldo berhasil ditambahkan');
      await getBankAmount();
    } catch (e) {
      log('Error di fillBankCredit: $e');
    }
  }

  Future<void> debitBankCredit(
    double amount,
    String bankTujuan,
    String status,
    String typeBank,
    double? adminFee,
  ) async {
    var getBankAccount = homeController.bankAccount.value;

    try {
      final bankDoc = await firestoreService.getData(
        'bankAccounts',
        getBankAccount,
      );

      if (bankDoc.exists) {
        double currentAmount = (bankDoc['amount'] as num).toDouble();
        log('Saldo sekarang: $currentAmount');

        double updatedAmount = currentAmount;
        if (status == 'SUCCESS') {
          updatedAmount -= amount + (adminFee ?? 0.0);
        }

        await firestoreService.setData(
          'bankAccounts',
          getBankAccount,
          {
            'bankAccount': getBankAccount,
            'amount': updatedAmount,
            'type_bank': currentBanktype.value,
          },
        );

        await firestoreService.addData(
          'bankAccounts/$getBankAccount/transactionsHistory',
          {
            'type': 'debit',
            'type_bank': typeBank,
            'status': status,
            'target_rekening': bankTujuan,
            'source_rekening': getBankAccount,
            'amount': amount,
            'admin_fee': adminFee ?? 0,
            'date': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
          },
        );

        log(status == 'SUCCESS'
            ? 'Saldo berhasil dikurangi'
            : 'Transaksi gagal, saldo tidak dikurangi');
      } else {
        // Jika dokumen tidak ada, buat dokumen baru tanpa mengurangi saldo
        await firestoreService.setData(
          'bankAccounts',
          getBankAccount,
          {'bankAccount': getBankAccount, 'amount': 0, 'type_bank': typeBank},
        );
        log('Dokumen baru dibuat untuk bankAccount: $getBankAccount');
      }
    } catch (e) {
      log('on transaction controller : $e');
    }
  }

  Future<double> getBankAmount() async {
    var getBankAccount = homeController.bankAccount.value;
    log('Get Bank Account: $getBankAccount');

    if (getBankAccount.isEmpty) {
      log('Bank account path is empty.');
      saldoAmount.value = 0.0;
      return 0.0;
    }

    try {
      final bankDoc = await firestoreService.getData(
        'bankAccounts',
        getBankAccount,
      );

      // Memastikan bahwa 'amount' dikonversi ke double
      double amount =
          bankDoc.exists ? (bankDoc['amount'] as num).toDouble() : 0.0;

      saldoAmount.value = amount;
      return amount;
    } catch (e) {
      log('Error getting bank amount: $e');
      rethrow;
    }
  }

  Future<void> getTransactionHistory() async {
    try {
      final snapshot = await firestoreService.getSubCollection(
        'bankAccounts/${homeController.bankAccount.value}/transactionsHistory',
      );

      if (snapshot.docs.isNotEmpty) {
        historyTransferUser.value = snapshot.docs.map((doc) {
          return doc.data();
        }).toList();

        // Urutkan data berdasarkan tanggal terbaru
        historyTransferUser.sort((a, b) {
          DateTime dateA = DateTime.parse(a['date']);
          DateTime dateB = DateTime.parse(b['date']);
          return dateB.compareTo(dateA);
        });
      } else {
        historyTransferUser.clear();
      }
    } catch (e) {
      log('Error fetching transaction history: $e');
    }
  }

  Future<bool> findRekening(String rekening) async {
    try {
      final bankDoc = await firestoreService.getData(
        'bankAccounts',
        rekening,
      );

      if (bankDoc.exists) {
        log('Rekening ditemukan: $rekening');
        await getUserDetailByRekening(rekening: rekening);
        return true;
      } else {
        log('Rekening tidak ditemukan: $rekening');
        return false;
      }
    } catch (e) {
      log('Error finding rekening: $e');
      rethrow;
    }
  }

  Future<void> getUserDetailByRekening({required String rekening}) async {
    try {
      final response = await firestoreService.getCollection('users');

      final snapshot =
          response.docs.where((doc) => doc['bankAccount'] == rekening).toList();

      if (snapshot.isNotEmpty) {
        final result = snapshot.first.data();

        userDataFirebase.value =
            FirebaseUserModel.fromJson(result as Map<String, dynamic>);
      } else {
        log('Rekening tidak ditemukan di koleksi users');
      }
    } catch (e) {
      log('Error di profile controller: $e');
    }
  }

  Future<void> createTransaction(
    double amount,
  ) async {
    var transactionTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(
      DateTime.now(),
    );

    var receiverData = userDataFirebase.value!.username;
    var senderData = box.read(KeyConstant.username);

    var bodyRequestCreateTransaction = {
      "\$class": "org.meetcoin.transaction.CreateTransaction",
      "sender": senderData,
      "receiver": receiverData,
      "transactionTime": transactionTime,
      "amount": amount,
      "status": "SUCCESS",
      "timestamp": transactionTime
    };

    try {
      await DioService.instance.postRequest(
        '/org.meetcoin.transaction.CreateTransaction',
        bodyRequestCreateTransaction,
      );

      log('Transaction created successfully');
    } catch (e) {
      log(e.toString());
    }
  }
}
