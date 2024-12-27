import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/styles/dev_color.dart';
import '../../../../core/styles/typography.dart';
import '../../../../core/widgets/dev_button.dart';
import '../../../../core/widgets/dev_textfield.dart';
import '../../controllers/transaction_controller.dart';

class SameBankComponent extends StatefulWidget {
  final double dWidth;
  const SameBankComponent({
    super.key,
    required this.dWidth,
  });

  @override
  State<SameBankComponent> createState() => _SameBankComponentState();
}

class _SameBankComponentState extends State<SameBankComponent> {
  final bankTujuan = TextEditingController(
    text: 'Bank BiCoin',
  );
  final rekeningTujuan = TextEditingController();
  final nominal = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final transactionController = Get.put(TransactionController());

  String bankAccount = '';

  @override
  void initState() {
    super.initState();
  }

  void validateBankAccountExist() async {
    double amount = double.parse(nominal.text);

    try {
      bool rekeningExists =
          await transactionController.findRekening(rekeningTujuan.text);

      if (rekeningExists) {
        await transactionController.debitBankCredit(
          amount,
          rekeningTujuan.text,
          'SUCCESS',
          'BiCoin',
          0,
        );

        await transactionController.fillBankCredit(
          amount,
          'BiCoin',
          bankAccount: rekeningTujuan.text,
          adminFee: 0,
        );

        await transactionController.createTransaction(amount);

        log('Transaksi berhasil dilakukan');
        transactionController.loadInitialData();
        Get.snackbar(
          'Sukses',
          'Transfer ke Rekening ${rekeningTujuan.text} berhasil',
          backgroundColor: DevColor.greenColor,
          colorText: DevColor.whiteColor,
          snackPosition: SnackPosition.TOP,
        );

        if (mounted) {
          transactionController.loadInitialData();
          Navigator.pop(context);
        }
      } else {
        await transactionController.debitBankCredit(
          amount,
          rekeningTujuan.text,
          'FAILED',
          'BiCoin',
          0,
        );
        Get.snackbar(
          'Failed',
          'Rekening ${rekeningTujuan.text} tidak ditemukan',
          backgroundColor: DevColor.redColor,
          colorText: DevColor.whiteColor,
          snackPosition: SnackPosition.TOP,
        );
        if (mounted) {
          transactionController.loadInitialData();
          Navigator.pop(context);
        }

        log('Rekening tidak ditemukan');
      }
    } catch (e) {
      log('Error validating bank account: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DevTextField(
            title: 'Bank Tujuan',
            readOnly: true,
            // styleTitle: DevTypograph.body1.bold.copyWith(
            //   color: DevColor.darkblue,
            // ),
            colorBorder: DevColor.darkblue,
            controller: bankTujuan,
            hint: 'Masukan bank tujuan anda',
          ),
          SizedBox(
            height: widget.dWidth / 20,
          ),
          DevTextField(
            title: 'Rekening Tujuan',
            // styleTitle: DevTypograph.body1.bold.copyWith(
            //   color: DevColor.darkblue,
            // ),
            keyboardType: TextInputType.number,
            colorBorder: DevColor.darkblue,
            controller: rekeningTujuan,
            hint: '1234',
          ),
          SizedBox(
            height: widget.dWidth / 20,
          ),
          DevTextField(
            title: 'Nominal',
            // styleTitle: DevTypograph.body1.bold.copyWith(
            //   color: DevColor.darkblue,
            // ),
            keyboardType: TextInputType.number,
            colorBorder: DevColor.darkblue,
            controller: nominal,
            hint: 'Masukan nominal anda',
          ),
          SizedBox(
            height: widget.dWidth / 10,
          ),
          SizedBox(
            width: double.infinity,
            child: DevButton(
              title: 'Selanjutnya',
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  // validateBankAccountExist();
                  modalconfirm();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void modalconfirm() {
    showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          height: widget.dWidth / 1.2,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),
          decoration: const BoxDecoration(
            color: DevColor.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Konfirmasi Transfer',
                style: DevTypograph.heading3.bold.copyWith(
                  color: DevColor.darkblue,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                'Bank Tujuan: ${bankTujuan.text}',
                style: DevTypograph.body1.bold.copyWith(
                  color: DevColor.darkblue,
                ),
              ),
              Text(
                'Rekening Tujuan: ${rekeningTujuan.text}',
                style: DevTypograph.body1.bold.copyWith(
                  color: DevColor.darkblue,
                ),
              ),
              Text(
                'Nominal: ${nominal.text} BIC',
                style: DevTypograph.body1.bold.copyWith(
                  color: DevColor.darkblue,
                ),
              ),
              Text(
                'Biaya Admin: 0 BIC',
                style: DevTypograph.body1.bold.copyWith(
                  color: DevColor.darkblue,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Pastikan rekening tujuan benar dan nominal sesuai!',
                style: DevTypograph.body1.regular.copyWith(
                  color: DevColor.darkblue,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: DevButton(
                  title: 'Konfirmasi',
                  onPressed: () {
                    validateBankAccountExist();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
