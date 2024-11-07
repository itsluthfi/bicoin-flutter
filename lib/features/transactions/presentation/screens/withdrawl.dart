import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/styles/dev_color.dart';
import '../../../../core/styles/typography.dart';
import '../../controllers/transaction_controller.dart';
import '../../controllers/transaction_different_bank_controller.dart';
import '../components/different_bank_component.dart';
import '../components/same_bank_component.dart';

class WithdrawlScreen extends StatefulWidget {
  const WithdrawlScreen({super.key});

  @override
  State<WithdrawlScreen> createState() => _WithdrawlScreenState();
}

class _WithdrawlScreenState extends State<WithdrawlScreen> {
  final transactionController = Get.put(TransactionController());
  final transactionDifferentController =
      Get.put(TransactionDifferentBankController());
  bool isSameBank = false;
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
          'Transfer Antar Bank',
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
