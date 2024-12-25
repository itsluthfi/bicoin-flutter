import 'dart:developer';

import 'package:dev_coinku/core/constants/key_constant.dart';
import 'package:dev_coinku/core/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/services/network_service.dart';
import '../../../auth/models/user_model.dart';

class ProfileController extends GetxController {
  final box = GetStorage();
  var user = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    getUserDetail();
  }

  void getUserDetail() async {
    var getUsername = await box.read(KeyConstant.username);
    // print(getUsername);

    // try {
    //   final response = await DioService.instance.getRequest(
    //     '/api/user/detail',
    //     // '/org.meetcoin.participant.Users/$getUsername',
    //   );

    //   final Map<String, dynamic> result = response.data;
    //   log(result.toString());

    //   user.value = UserModel.fromJson(result['data']);
    // } catch (e) {
    //   log(e.toString());
    // }

    try {
      Map<String, dynamic>? userData =
          await AuthService().getUserByEmail(getUsername);
      if (userData != null) {
        print('User Data: $userData');
        final Map<String, dynamic> result = userData;

        user.value = UserModel.fromJson(result);
        print(user.value?.name);
      } else {
        print('User not found');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
