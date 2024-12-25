import 'dart:developer';

import 'package:dev_coinku/features/dashboard/home/models/user_rekening.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/constants/key_constant.dart';
import '../../../../core/services/firestore_service.dart';

class HomeController extends GetxController {
  FirestoreService firestoreService = FirestoreService();
  final box = GetStorage();
  RxString bankAccount = ''.obs;
  RxString currentTypeBank = ''.obs;

  Future<void> getRekeningUser() async {
    var usernameId = await box.read(KeyConstant.username);
    try {
      final snapshot = await firestoreService.getCollection('users').then(
            (value) =>
                value.docs.where((doc) => doc['email'] == usernameId).toList(),
          );

      if (snapshot.isNotEmpty) {
        final result = snapshot.first.data();

        var rekeningUser = UserRekening.fromJson(
          result as Map<String, dynamic>,
        );

        //assign value ke RxString
        bankAccount.value = rekeningUser.bankAccount;
        currentTypeBank.value = rekeningUser.typeBank;
      } else {
        log('User with id $usernameId not found');
      }
    } catch (e) {
      log('Error on home controller fetching user data : $e');
    }
  }
}
