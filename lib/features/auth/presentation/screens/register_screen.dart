import 'package:dev_coinku/core/services/auth_service.dart';
import 'package:dev_coinku/core/widgets/dev_popup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/styles/typography.dart';
import '../../../../core/widgets/dev_button.dart';
import '../../../../core/widgets/dev_textfield.dart';
import '../../controllers/auth_controller.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  static const route = '/register';
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final nameController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    final authC = Get.put(AuthController());

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
                'Register',
                style: DevTypograph.heading2.bold,
              ),
              Text(
                'gabung untuk memulai transaksi',
                style: DevTypograph.body1.medium,
              ),
              const SizedBox(height: 24),
              DevTextField(
                title: 'Username',
                controller: usernameController,
                hint: 'Masukan username anda',
              ),
              const SizedBox(height: 10),
              DevTextField(
                title: 'Nama',
                controller: nameController,
                hint: 'Masukan nama anda',
              ),
              const SizedBox(height: 10),
              DevTextField(
                title: 'Email',
                controller: emailController,
                hint: 'Masukan email anda',
              ),
              const SizedBox(height: 10),
              DevTextField(
                title: 'Nomor telepon',
                controller: phoneController,
                keyboardType: TextInputType.number,
                hint: 'Masukan nomor telepon anda',
              ),
              const SizedBox(height: 10),
              DevTextField(
                title: 'Password',
                controller: passwordController,
                isPassword: true,
                hint: 'Masukan password anda',
              ),
              const SizedBox(height: 24),
              Obx(() {
                if (authC.isLoading.value) {
                  Future.microtask(() => DevPopup.loading(context));
                } else {
                  return SizedBox(
                    width: double.infinity,
                    child: DevButton(
                      title: 'Daftar',
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          authC.register(
                            usernameController.text,
                            nameController.text,
                            emailController.text,
                            phoneController.text,
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
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Column(
              children: [
                headSection(),
                formSection(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sudah punya akun?',
                      style: DevTypograph.body1.medium,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(LoginScreen.route);
                      },
                      child: Text(
                        'Masuk',
                        style: DevTypograph.body1.medium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
