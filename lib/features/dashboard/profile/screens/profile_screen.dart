import 'package:dev_coinku/core/services/fcm_service.dart';
import 'package:dev_coinku/core/utils/format_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/constants/key_constant.dart';
import '../../../../core/styles/dev_color.dart';
import '../../../../core/styles/typography.dart';
import '../../../auth/presentation/screens/login_screen.dart';
import '../controllers/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  static const route = '/profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final profileController = Get.put(ProfileController());
  final fcmService = FcmService();
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    profileController.getUserDetail();
  }

  void logout() async {
    await box.remove(KeyConstant.username);
    await fcmService.unsubscribeFromTopic('coinku');
    Get.snackbar(
      'Logout Success',
      'See you again',
      backgroundColor: DevColor.orange,
      colorText: DevColor.whiteColor,
      duration: const Duration(milliseconds: 1700),
    );
    Get.toNamed(LoginScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    final user = profileController.user;

    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: const Color(0xFF003366),
                width: double.infinity,
                padding: const EdgeInsets.only(top: 64, bottom: 20),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Text(
                        "${user.value?.username.toString().getInitials()}",
                        style: const TextStyle(
                          color: Color(0xFF003366),
                          fontSize: 40,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${user.value?.name.toString().toCamelCase()}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildProfileItem(
                        'Nomor Handphone', "${user.value?.noTelp}"),
                    buildProfileItem('Alamat Email', "${user.value?.email}"),
                    buildProfileItem('Username', "${user.value?.username}"),
                    buildProfileItem('Bahasa', 'Indonesia'),
                  ],
                ),
              ),
              InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: logout,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(children: [
                    const Icon(
                      Icons.logout_sharp,
                      color: DevColor.redColor,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Logout',
                      style: DevTypograph.body1.bold.copyWith(
                        color: DevColor.redColor,
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget buildProfileItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
