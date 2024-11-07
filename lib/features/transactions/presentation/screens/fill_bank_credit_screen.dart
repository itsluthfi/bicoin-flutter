import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/styles/dev_color.dart';
import '../../../../core/styles/typography.dart';
import '../../../../core/widgets/dev_button.dart';
import '../../../../core/widgets/dev_textfield.dart';
import '../../controllers/transaction_controller.dart';

class FillBankCreditScreen extends StatefulWidget {
  const FillBankCreditScreen({super.key});

  @override
  State<FillBankCreditScreen> createState() => _FillBankCreditScreenState();
}

class _FillBankCreditScreenState extends State<FillBankCreditScreen> {
  final amountCreditController = TextEditingController();

  final transactionController = Get.put(TransactionController());
  final keyForm = GlobalKey<FormState>();

  void isiSaldo() async {
    var amountCredit = double.parse(amountCreditController.text);

    try {
      await transactionController.fillBankCredit(amountCredit, 'pribadi');
      await transactionController.getTransactionHistory();
      Get.snackbar(
        'Success',
        'Isi saldo ${amountCreditController.text} berhasil',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      amountCreditController.clear();
    } catch (e) {
      await transactionController.getTransactionHistory();
      Get.snackbar(
        'Failed',
        'Isi saldo ${amountCreditController.text} gagal',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      log('error fill credit bank: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DevColor.darkblue,
        title: Text(
          'Fill Bank Credit',
          style: DevTypograph.heading3.bold.copyWith(
            color: DevColor.whiteColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Anda dapat mengisi form di bawah ini untuk menyelesaikan transaksi',
              style: DevTypograph.body1.bold,
            ),
            const SizedBox(height: 24),
            Form(
              key: keyForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Text(
                      'Rekening Anda: ${transactionController.bankAccount}',
                      style: DevTypograph.body2.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DevTextField(
                    title: 'Isi nominal',
                    keyboardType: TextInputType.number,
                    controller: amountCreditController,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: DevButton(
                      title: 'Submit',
                      onPressed: () async {
                        if (keyForm.currentState!.validate()) {
                          isiSaldo();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
