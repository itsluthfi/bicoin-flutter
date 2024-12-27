import 'package:dev_coinku/core/services/auth_service.dart';
import 'package:dev_coinku/features/auth/presentation/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/styles/dev_color.dart';
import '../../../../core/styles/typography.dart';
import '../../../../core/widgets/dev_button.dart';
import '../../../../core/widgets/dev_popup.dart';
import '../../../../core/widgets/dev_textfield.dart';
import '../../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  static const route = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final authC = Get.put(AuthController());

  @override
  void initState() {
    super.initState();

    // authC.getUserDataList();
  }

  @override
  Widget build(BuildContext context) {
    headSection() {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/intro_logoo.png',
                fit: BoxFit.cover,
                scale: 1.5,
              ),
              Image.asset(
                'assets/intro_illus.png',
                fit: BoxFit.fitHeight,
                scale: 1.5,
              ),
            ],
          ),
        ),
      );
    }

    formSection() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        width: double.infinity,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Masuk',
                style: DevTypograph.heading2.bold,
              ),
              Text(
                'masuk untuk memulai transaksi',
                style: DevTypograph.body1.medium,
              ),
              const SizedBox(height: 24),
              DevTextField(
                title: 'Email',
                // colorBorder: DevColor.darkblue,
                controller: usernameController,
                hint: 'user1234@gmail.com',
              ),
              const SizedBox(height: 10),
              DevTextField(
                title: 'Password',
                controller: passwordController,
                isPassword: true,
                hint: 'user1234',
              ),
              const SizedBox(height: 24),
              Obx(() {
                if (authC.isLoading.value) {
                  Future.microtask(() => DevPopup.loading(context));
                } else {
                  return SizedBox(
                    width: double.infinity,
                    child: DevButton(
                      title: 'Masuk',
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          authC.login(
                            usernameController.text,
                            passwordController.text,
                          );
                        }
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              headSection(),
              formSection(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum punya akun?',
                    style: DevTypograph.body1.medium,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(RegisterScreen.route);
                    },
                    child: Text(
                      'Daftar sekarang',
                      style: DevTypograph.body1.medium,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
