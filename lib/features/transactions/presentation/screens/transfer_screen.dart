import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/styles/dev_color.dart';
import '../../../../core/styles/typography.dart';
import '../../controllers/transaction_controller.dart';
import '../../controllers/transaction_different_bank_controller.dart';
import '../components/different_bank_component.dart';
import '../components/same_bank_component.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final transactionController = Get.put(TransactionController());
  final transactionDifferentController =
      Get.put(TransactionDifferentBankController());
  bool isSameBank = true;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    transactionDifferentController.getAllBank();
    // transactionDifferentController.getAllBankList();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    transactionController.bankAccount.value;
    // transactionDifferentController.getAllBank();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var dWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: DevColor.darkblue,
        elevation: 0,
        title: Text(
          'Transfer Sesama Bank',
          style: DevTypograph.heading3.bold.copyWith(
            color: DevColor.whiteColor,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          transactionDifferentController.getAllBank();
        },
        child: ListView(
          children: [
            transferPageWidgets(dWidth),
          ],
        ),
      ),
    );
  }

  Widget transferPageWidgets(dWidth) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rekening Bank Kamu',
              style: DevTypograph.heading2.bold.copyWith(
                color: DevColor.darkblue,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Obx(() {
              return Text(
                'No. Rekening : ${transactionController.bankAccount}',
                style: DevTypograph.body1.bold.copyWith(
                  color: DevColor.darkblue,
                ),
              );
            }),
            const SizedBox(
              height: 5,
            ),
            Obx(() {
              final saldo = transactionController.saldoAmount.value;
              return Text(
                'Saldo : Rp ${NumberFormat('#,##0', 'ID').format(saldo)}',
                style: DevTypograph.body1.bold.copyWith(
                  color: DevColor.darkblue,
                ),
              );
            }),
            SizedBox(
              height: dWidth / 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // GestureDetector(
                //   onTap: () {
                //     setState(() {
                //       isSameBank = !isSameBank;
                //     });
                //   },
                //   child: Container(
                //     width: dWidth / 2.5,
                //     padding: EdgeInsets.all(dWidth / 20),
                //     decoration: BoxDecoration(
                //         color: isSameBank
                //             ? DevColor.darkblue
                //             : const Color(0xff979797),
                //         borderRadius: BorderRadius.all(
                //           Radius.circular(dWidth / 20),
                //         )),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Image.asset(
                //           'assets/coinku_white.png',
                //           scale: 3,
                //         ),
                //         SizedBox(
                //           height: dWidth / 40,
                //         ),
                //         SizedBox(
                //           width: dWidth / 3,
                //           child: Text(
                //             'Transfer sesama bank',
                //             style: DevTypograph.body1.bold.copyWith(
                //               color: Colors.white,
                //             ),
                //           ),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                // GestureDetector(
                //   onTap: () {
                //     setState(() {
                //       isSameBank = !isSameBank;
                //     });
                //   },
                //   child: Container(
                //     width: dWidth / 2.5,
                //     padding: EdgeInsets.all(dWidth / 20),
                //     decoration: BoxDecoration(
                //         color: !isSameBank
                //             ? DevColor.orange
                //             : const Color(0xff979797),
                //         borderRadius: BorderRadius.all(
                //           Radius.circular(dWidth / 20),
                //         )),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Icon(
                //           Icons.house,
                //           color: Colors.white,
                //           size: dWidth / 10,
                //         ),
                //         SizedBox(
                //           height: dWidth / 40,
                //         ),
                //         SizedBox(
                //           width: dWidth / 3,
                //           child: Text(
                //             'Transfer antar bank',
                //             style: DevTypograph.body1.bold.copyWith(
                //               color: Colors.white,
                //             ),
                //           ),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
            SizedBox(
              height: dWidth / 20,
            ),
            isSameBank
                ? SameBankComponent(dWidth: dWidth)
                : DifferentBankComponent(dWidth: dWidth),
          ],
        ),
      ),
    );
  }
}
