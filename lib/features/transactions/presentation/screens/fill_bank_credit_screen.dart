import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
      await transactionController.fillBankCredit(amountCredit, 'Isi Saldo');
      await transactionController.getTransactionHistory();
      Get.snackbar(
        'Sukses',
        'Isi saldo ${amountCreditController.text} berhasil',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      amountCreditController.clear();
    } catch (e) {
      await transactionController.getTransactionHistory();
      Get.snackbar(
        'Gagal',
        'Isi saldo ${amountCreditController.text} gagal',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      log('error isi saldo: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DevColor.darkblue,
        title: Text(
          'Isi Saldo',
          style: DevTypograph.heading3.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kotak untuk Rekening Bank Kamu
            SizedBox(
              width: double.infinity,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: DevColor.darkblue, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rekening Bank Kamu',
                      style: DevTypograph.heading2.bold.copyWith(
                        color: DevColor.darkblue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(() {
                      return Text(
                        'No. Rekening: ${transactionController.bankAccount}',
                        style: DevTypograph.body1.bold.copyWith(
                          color: DevColor.darkblue,
                        ),
                      );
                    }),
                    const SizedBox(height: 8),
                    Obx(() {
                      final saldo = transactionController.saldoAmount.value;
                      return Text(
                        'Saldo: ${NumberFormat('#,##0', 'ID').format(saldo)} BIC',
                        style: DevTypograph.body1.bold.copyWith(
                          color: DevColor.darkblue,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Form dan tombol (tidak diubah)
            Form(
              key: keyForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DevTextField(
                    title: 'Nominal',
                    // styleTitle: DevTypograph.body1.bold.copyWith(
                    //   color: DevColor.darkblue,
                    // ),
                    keyboardType: TextInputType.number,
                    controller: amountCreditController,
                    colorBorder: DevColor.darkblue,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: DevButton(
                      title: 'Selanjutnya',
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
