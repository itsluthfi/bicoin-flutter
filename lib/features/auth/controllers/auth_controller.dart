import 'dart:developer';

import 'package:dev_coinku/core/services/auth_service.dart';
import 'package:dev_coinku/core/services/fcm_service.dart';
import 'package:dev_coinku/core/utils/format_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/constants/key_constant.dart';
import '../../../core/services/firestore_service.dart';
import '../../../core/services/network_service.dart';
import '../../../core/styles/dev_color.dart';
import '../../../core/utils/generator_util.dart';
import '../../dashboard/navbar_screen.dart';
import '../presentation/screens/login_screen.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var isSuccess = false.obs;
  final box = GetStorage();
  final AuthService _authService = AuthService();

  RxList<dynamic> dataUsers = <dynamic>[].obs;
  FirestoreService firestoreService = FirestoreService();
  final fcmService = FcmService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void onInit() {
    // getUserDataList();
    super.onInit();
  }

  void getUserDataList() async {
    try {
      final response = await DioService.instance.getRequest(
        '/org.meetcoin.participant.Users',
      );

      dataUsers.value = response.data;
      log(response.data.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  dynamic findUser(
    String username, {
    String? email,
    String? password,
  }) {
    return dataUsers.firstWhere(
      (user) => user['username'] == username && user['password'] == password,
      orElse: () => null,
    );
  }

  Future<void> login(String username, String password) async {
    // var user = await findUser(username, password: password) != null;
    await box.write(KeyConstant.username, username);

    // var bodyRequest = {'username': username, 'password': password};

    // var responseData = await DioService.instance.postRequestAuth(
    //   '/api/login',
    //   bodyRequest,
    // );
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: username,
        password: password,
      );

      if (userCredential.user != null) {
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
        print(box.read(KeyConstant.token));

        Get.offAllNamed(NavigatorBar.route);
      }

      // return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Menangani error FirebaseAuth
      print('Login Error: ${e.message}');
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
      // throw e;
    } catch (e) {
      // Menangani error lainnya
      print('Error: $e');
      // throw e;
    }
    // var user = responseData.data['token'];

    //   if (user != null) {
    //     // await box.write(KeyConstant.token, user);

    //   } else {

    //   }
    // } catch (e) {
    //   log(e.toString());
    // }
  }

  Future<void> register(
    String username,
    String name,
    String email,
    String phone,
    String password,
  ) async {
    // var isUserExist =
    //     await findUser(username) != null || findUser('', email: email) != null;

    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // return userCredential.user;

      if (userCredential.user != null) {
        var bankAccount = generateRandomBankAccountNumber();

        // send data to firestrore
        await firestoreService.setData('users', username, {
          'username': username.toLowerCase(),
          'name': name,
          'email': email,
          'no_telp': phone,
          'bankAccount': bankAccount,
          'type_bank': 'coinku',
        });

        Get.snackbar(
          'Register Success',
          'Please login to continue',
          backgroundColor: DevColor.greenColor,
          colorText: DevColor.whiteColor,
          duration: const Duration(milliseconds: 1700),
        );
        isLoading(false);
        Get.toNamed(LoginScreen.route);
        // } catch (e) {
        //   log(e.toString());
      }
    } on FirebaseAuthException catch (e) {
      // Menangani error FirebaseAuth
      print('Register Error: ${e.message}');
      isLoading(true);
      isSuccess(false);
      errorMessage('Username or Email already exist');
      Get.snackbar(
        'Register Failed',
        'Email already taken',
        backgroundColor: DevColor.redColor,
        colorText: DevColor.whiteColor,
        duration: const Duration(milliseconds: 1700),
      );
      isLoading(false);
    } catch (e) {
      // Menangani error lainnya
      print('Error: $e');
      // throw e;
      // isLoading(true);
      // isSuccess(true);
      // errorMessage('');
    }

    // } else {

    // var bodyRequest = {
    //   '\$class': 'org.meetcoin.participant.Users',
    //   'username': username.toLowerCase(),
    //   'name': name,
    //   'email': email,
    //   'phone': phone,
    //   'password': password
    // };

    // } catch (e) {
    //   print('Registration failed: $e');

    // try {
    //   // await DioService.instance.postRequestAuth(
    //   //   '/api/register',
    //   //   bodyRequest,
    //   // );

    //   User? user = await _authService.registerWithEmailPassword(
    //     // nameController.text,
    //     // phoneController.text,
    //     email,
    //     password,
    //   );
    //   if (user != null) {
    //     print('Registration successful: ${user.email}');
    //   }

    // }
    // } catch (e) {
    //   log(e.toString());
    // } finally {
    //   isLoading(false);
    // }
  }
}
