import 'dart:developer';

import 'package:dev_coinku/core/services/fcm_service.dart';
import 'package:dev_coinku/core/utils/format_util.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/constants/key_constant.dart';
// import '../../../core/services/firestore_service.dart';
import '../../../core/services/network_service.dart';
import '../../../core/styles/dev_color.dart';
// import '../../../core/utils/generator_util.dart';
import '../../dashboard/navbar_screen.dart';
import '../presentation/screens/login_screen.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var isSuccess = false.obs;
  final box = GetStorage();
  RxList<dynamic> dataUsers = <dynamic>[].obs;
  // FirestoreService firestoreService = FirestoreService();
  final fcmService = FcmService();

  @override
  void onInit() {
    // getUserDataList();
    super.onInit();
  }

  // void getUserDataList() async {
  //   try {
  //     final response = await DioService.instance.getRequest(
  //       '/org.meetcoin.participant.Users',
  //     );
  //
  //     dataUsers.value = response.data;
  //     log(response.data.toString());
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }
  //
  // dynamic findUser(
  //   String username, {
  //   String? email,
  //   String? password,
  // }) {
  //   return dataUsers.firstWhere(
  //     (user) => user['username'] == username && user['password'] == password,
  //     orElse: () => null,
  //   );
  // }

  Future<void> login(String username, String password) async {
    try {
      // var user = await findUser(username, password: password) != null;
      await box.write(KeyConstant.username, username);
      if (true) {
        isSuccess(true);
        isLoading(true);
        errorMessage('');
        await fcmService.subscribeToTopic('coinku');
        Get.snackbar(
          'Login Success',
          'Welcome back ${username.toString().toCamelCase()}',
          backgroundColor: DevColor.greenColor,
          colorText: DevColor.whiteColor,
          duration: const Duration(milliseconds: 1700),
        );
        isLoading(false);
        Get.offAllNamed(NavigatorBar.route);
      } else {
        isLoading(true);
        isSuccess(false);

        Get.snackbar(
          'Login Failed',
          'Username or Password incorrect',
          backgroundColor: DevColor.redColor,
          colorText: DevColor.whiteColor,
          duration: const Duration(milliseconds: 1700),
        );
        isLoading(false);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> register(
      String name,
      String email,
      String username,
      String phone,
      String password,
  ) async {
    // var isUserExist =
    //     await findUser(username) != null || findUser('', email: email) != null;

    try {
      if (false) {
        isLoading(true);
        isSuccess(false);
        errorMessage('Username or Email already exist');
        Get.snackbar(
          'Register Failed',
          'Username already taken',
          backgroundColor: DevColor.redColor,
          colorText: DevColor.whiteColor,
          duration: const Duration(milliseconds: 1700),
        );
        isLoading(false);
      } else {
        isLoading(true);
        isSuccess(true);
        errorMessage('');

        var bodyRequest = {
          'name': name,
          'email': email,
          'username': username,
          'phone': phone,
          'password': password,
        };

        // var bankAccount = generateRandomBankAccountNumber();

        try {
          await DioService.instance.postRequest(
            '/register',
            bodyRequest,
          );

          // // send data to firestrore
          // await firestoreService.setData('users', username, {
          //   'username': username.toLowerCase(),
          //   'name': name,
          //   'email': email,
          //   'no_telp': phone,
          //   'bankAccount': bankAccount,
          //   'type_bank': 'coinku',
          // });

          Get.snackbar(
            'Register Success',
            'Please login to continue',
            backgroundColor: DevColor.greenColor,
            colorText: DevColor.whiteColor,
            duration: const Duration(milliseconds: 1700),
          );
          isLoading(false);
          Get.toNamed(LoginScreen.route);
        } catch (e) {
          log(e.toString());
        }
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
