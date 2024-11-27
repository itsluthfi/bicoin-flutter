import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:dev_coinku/core/utils/format_util.dart';
import 'package:get/get.dart' as get_package;
import 'package:get_storage/get_storage.dart';

import '../../../core/constants/key_constant.dart';
import '../../../core/styles/dev_color.dart';
import '../../dashboard/navbar_screen.dart';
import '../presentation/screens/login_screen.dart';

class AuthController extends get_package.GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var isSuccess = false.obs;
  final box = GetStorage();
  get_package.RxList<dynamic> dataUsers = <dynamic>[].obs;

  final dio = Dio();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> login(String username, String password) async {
    try {
      await box.write(KeyConstant.username, username);
      
      isSuccess(true);
      isLoading(true);
      errorMessage('');
      get_package.Get.snackbar(
        'Login Success',
        'Welcome back ${username.toString().toCamelCase()}',
        backgroundColor: DevColor.greenColor,
        colorText: DevColor.whiteColor,
        duration: const Duration(milliseconds: 1700),
      );
      isLoading(false);
      get_package.Get.offAllNamed(NavigatorBar.route);
      isLoading(true);
      isSuccess(false);
        
      get_package.Get.snackbar(
        'Login Failed',
        'Username or Password incorrect',
        backgroundColor: DevColor.redColor,
        colorText: DevColor.whiteColor,
        duration: const Duration(milliseconds: 1700),
      );
      isLoading(false);
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

    isLoading(true); // Start loading
    isSuccess(false); // Reset success state
    errorMessage(''); // Reset error message

    Response response;

    final bodyRequest = {
      'name': name,
      'email': email,
      'username': username,
      'phone': phone,
      'password': password,
    };

    try {
      response = await dio.post('http://10.0.2.2:8080/api/register', data: bodyRequest);
      log(response.data.toString());

      // Success message and navigation
      get_package.Get.snackbar(
        'Register Success',
        'Please login to continue',
        backgroundColor: DevColor.greenColor,
        colorText: DevColor.whiteColor,
        duration: const Duration(milliseconds: 1700),
      );
      isSuccess(true);
      get_package.Get.toNamed(LoginScreen.route);
    } catch (e) {
      // Error handling and logging
      log(e.toString());
    } finally {
      isLoading(false); // Stop loading
    }
  }
}
