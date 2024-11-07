import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../core/constants/key_constant.dart';
import '../../core/styles/dev_color.dart';
import '../auth/presentation/screens/login_screen.dart';
import '../dashboard/navbar_screen.dart';

class SplashScreen extends StatefulWidget {
  static const route = '/splash_screen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      usernameExist();
    });
  }

  void usernameExist() async {
    await box.read(KeyConstant.username) == null
        ? Get.offAllNamed(LoginScreen.route)
        : Get.offAllNamed(NavigatorBar.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DevColor.darkblue,
      body: Center(
        child: Image.asset('assets/coinku.png'),
      ),
    );
  }
}
