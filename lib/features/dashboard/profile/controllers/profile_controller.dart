import 'dart:developer';

import 'package:dev_coinku/core/constants/key_constant.dart';
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

    try {
      final response = await DioService.instance.getRequest(
        '/org.meetcoin.participant.Users/$getUsername',
      );

      final Map<String, dynamic> result = response.data;
      log(result.toString());

      user.value = UserModel.fromJson(result);
    } catch (e) {
      log(e.toString());
    }
  }
}
