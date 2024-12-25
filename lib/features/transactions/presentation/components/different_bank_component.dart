import 'package:dev_coinku/core/widgets/dev_button.dart';
import 'package:dev_coinku/core/widgets/dev_dropdownsearch.dart';
import 'package:dev_coinku/core/widgets/dev_textfield.dart';
import 'package:dev_coinku/features/transactions/controllers/transaction_different_bank_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/styles/dev_color.dart';
import '../../../../core/styles/typography.dart';
import '../../controllers/transaction_controller.dart';

class DifferentBankComponent extends StatefulWidget {
  final double dWidth;

  const DifferentBankComponent({
    super.key,
    required this.dWidth,
  });

  @override
  State<DifferentBankComponent> createState() => _DifferentBankComponentState();
}

class _DifferentBankComponentState extends State<DifferentBankComponent> {
  final nominalController = TextEditingController();
  final rekeningController = TextEditingController();
  final bankTujuanController = TextEditingController();
  final transactionController = Get.put(TransactionDifferentBankController());
  final transactionControl = Get.put(TransactionController());

  final formKey = GlobalKey<FormState>();

  String? selectedBank;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nominalController.dispose();
    rekeningController.dispose();
    bankTujuanController.dispose();
  }

  void sendTransfer() async {
    if (formKey.currentState?.validate() == true) {
      await transactionController.validationUserByBank(
        amount: double.parse(nominalController.text),
        rekening: rekeningController.text,
        bankTujuan: selectedBank ?? '',
      );
      await transactionControl.loadInitialData();
    }
    if (mounted) {
      Get.snackbar(
        'Sukses',
        'Transaksi Berhasil',
        backgroundColor: DevColor.greenColor,
        colorText: DevColor.whiteColor,
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DevDropdownSearchForm(
            title: 'Bank Tujuan',
            styleTitle: DevTypograph.body1.bold.copyWith(
              color: DevColor.darkblue,
            ),
            controller: bankTujuanController,
            colorBorder: DevColor.darkblue,
            onChanged: (value) {
              setState(() {
                selectedBank = value!;
              });
            },
            dataItems: transactionController.bankList,
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
            controller: rekeningController,
            colorBorder: DevColor.darkblue,
          ),
          SizedBox(
            height: widget.dWidth / 40,
          ),
          DevTextField(
            title: 'Nominal',
            keyboardType: TextInputType.number,
            controller: nominalController,
            colorBorder: DevColor.darkblue,
          ),
          SizedBox(
            height: widget.dWidth / 10,
          ),
          SizedBox(
            width: widget.dWidth,
            child: DevButton(
              title: 'Selanjutnya',
              onPressed: modalconfirm,
            ),
          ),
        ],
      ),
    );
  }

  void modalconfirm() {
    double? nominal = double.tryParse(nominalController.text);

    if (nominal != null) {
      double adminFee = nominal * 0.05;

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
                  'Bank Tujuan: $selectedBank',
                  style: DevTypograph.body1.bold.copyWith(
                    color: DevColor.darkblue,
                  ),
                ),
                Text(
                  'Rekening Tujuan: ${rekeningController.text}',
                  style: DevTypograph.body1.bold.copyWith(
                    color: DevColor.darkblue,
                  ),
                ),
                Text(
                  'Nominal: Rp ${nominalController.text}',
                  style: DevTypograph.body1.bold.copyWith(
                    color: DevColor.darkblue,
                  ),
                ),
                Text(
                  'Biaya Admin: Rp ${adminFee.toStringAsFixed(0)}',
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
                      sendTransfer();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      Get.snackbar(
        'Input Salah',
        'Nominal tidak valid, harap masukkan angka yang benar',
        backgroundColor: DevColor.redColor,
        colorText: DevColor.whiteColor,
      );
    }
  }
}
