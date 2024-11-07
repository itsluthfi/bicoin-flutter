import 'package:dev_coinku/core/utils/format_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/styles/dev_color.dart';
import '../../../../core/styles/typography.dart';
import '../../../dashboard/home/controllers/home_controller.dart';
import '../../controllers/transaction_controller.dart';
import '../../models/user_transfer_history_model.dart';

class HistoryTransferScreen extends StatefulWidget {
  const HistoryTransferScreen({super.key});

  @override
  State<HistoryTransferScreen> createState() => _HistoryTransferScreenState();
}

class _HistoryTransferScreenState extends State<HistoryTransferScreen> {
  final transferController = Get.put(TransactionController());
  final homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    getTransactionHistory();
    getCurrentRekening();
  }

  Future<void> getTransactionHistory() async {
    await transferController.getTransactionHistory();
    await getCurrentRekening();
    setState(() {});
  }

  Future<void> getCurrentRekening() async {
    await homeController.getRekeningUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DevColor.darkblue,
        title: Text(
          'History Transfer',
          style: DevTypograph.heading3.bold.copyWith(
            color: DevColor.whiteColor,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return getTransactionHistory();
        },
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
              transferController.historyTransferUser.length,
              (index) {
                var data = transferController.historyTransferUser[index];
                var dataItemHistory = UserTransferHistoryModel.fromJson(data);

                var currentRek = homeController.bankAccount.value;

                String accountLabel = dataItemHistory.type == 'credit' &&
                        dataItemHistory.sourceRekening != currentRek.toString()
                    ? 'Dari Akun'
                    : 'Ke Akun';

                return cardListTransfer(
                  dataItemHistory.date,
                  dataItemHistory.amount,
                  dataItemHistory.type,
                  dataItemHistory.typeBank,
                  dataItemHistory.status,
                  accountLabel,
                  dataItemHistory.adminFee,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  cardListTransfer(
    String transferDate,
    double amountTransfer,
    String typeTransfer,
    String bankTujuan,
    String status,
    String accountLabel,
    double adminFee,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: DevColor.darkblue,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Transfer ${typeTransfer.toCamelCase()}',
                style: DevTypograph.body1.bold.copyWith(
                  color: DevColor.darkblue,
                ),
              ),
              Text(
                '$accountLabel ${bankTujuan.toCamelCase()}',
                style: DevTypograph.body1.medium.copyWith(
                  color: DevColor.darkblue,
                ),
              ),
              Text(
                'Admin Fee ${adminFee.toRupiah()}',
                style: DevTypograph.body1.medium.copyWith(
                  color: DevColor.darkblue,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                transferDate.toFormattedDate(),
                style: DevTypograph.body1.medium.copyWith(
                  color: DevColor.darkblue,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                typeTransfer == 'debit'
                    ? '- ${amountTransfer.toRupiah()}'
                    : '+ ${amountTransfer.toRupiah()}',
                style: DevTypograph.body1.bold.copyWith(
                  color: DevColor.darkblue,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: status == 'SUCCESS'
                        ? DevColor.primaryColor
                        : DevColor.redColor,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status == 'SUCCESS' ? 'Berhasil' : 'Gagal',
                  textAlign: TextAlign.center,
                  style: DevTypograph.body1.regular.copyWith(
                    color: status == 'SUCCESS'
                        ? DevColor.primaryColor
                        : DevColor.redColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
