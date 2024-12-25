import 'package:dev_coinku/core/utils/format_util.dart';
import 'package:dev_coinku/features/transactions/presentation/screens/withdrawl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/styles/dev_color.dart';
import '../../../../core/styles/typography.dart';
import '../../../transactions/controllers/transaction_controller.dart';
import '../../../transactions/models/user_transfer_history_model.dart';
import '../../../transactions/presentation/screens/fill_bank_credit_screen.dart';
import '../../../transactions/presentation/screens/transfer_screen.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/home_controller.dart';
import '../widgets/appbar_widget.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isShowAmount = false;
  final profileController = Get.put(ProfileController());
  final homeController = Get.put(HomeController());
  final transactionController = Get.put(TransactionController());

  List<String> iconButton = [
    'assets/icon/transfer.png',
    'assets/icon/wallet.png',
    'assets/icon/transference.png',
  ];

  List<String> titleButton = [
    'Transfer Saldo',
    'Isi Saldo',
    'Penarikan Saldo',
  ];

  List<Widget> directionMenuButton = [
    const TransferScreen(),
    const FillBankCreditScreen(),
    const WithdrawlScreen(),
  ];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await loadData();
  }

  Future<void> loadData() async {
    profileController.getUserDetail();
    await homeController.getRekeningUser();
    await transactionController.getBankAmount();
    await transactionController.getTransactionHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: DevColor.darkblue,
      appBar: const AppbarWidget(),
      body: RefreshIndicator(
        onRefresh: () {
          return loadData();
        },
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width / 3.5),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                            MediaQuery.of(context).size.width / 20),
                        topRight: Radius.circular(
                            MediaQuery.of(context).size.width / 20),
                      )),
                  child: Container(),
                ),
              ),
              homeScreenWidgets(MediaQuery.of(context).size.width),
            ],
          ),
        ),
      ),
    );
  }

  greetingSection() {
    return Column(
      children: [
        Text(
          'Selamat Datang,',
          style: DevTypograph.heading3.medium.copyWith(
            color: DevColor.whiteColor,
          ),
        ),
        Obx(() {
          final user = profileController.user.value;
          if (user == null) {
            return const SizedBox();
          }
          return Text(
            user.name.toCamelCase(),
            style: DevTypograph.heading3.bold.copyWith(
              color: DevColor.whiteColor,
            ),
          );
        }),
      ],
    );
  }

  homeScreenWidgets(dWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: dWidth / 20),
      child: SizedBox(
        width: dWidth,
        child: Column(
          children: [
            greetingSection(),
            SizedBox(height: dWidth / 20),
            rekeningInfo(),
            SizedBox(height: dWidth / 10),
            menuIconList(),
            historyTransaction(),
          ],
        ),
      ),
    );
  }

  rekeningInfo() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(MediaQuery.of(context).size.width / 40),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 10.2,
            offset: const Offset(3, 4),
            color: Colors.black.withOpacity(.15),
          )
        ],
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            var rekening = homeController.bankAccount.value;
            return Text(
              'Rekening : $rekening',
              style: DevTypograph.body1.bold.copyWith(
                color: DevColor.darkblue,
              ),
            );
          }),
          SizedBox(height: MediaQuery.of(context).size.width / 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() {
                var saldo = transactionController.saldoAmount.value;
                return Text(
                  'Saldo : Rp ${isShowAmount ? NumberFormat('#,##0', 'ID').format(saldo) : '******'}',
                  style: DevTypograph.body1.regular.copyWith(
                    color: DevColor.darkblue,
                  ),
                );
              }),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isShowAmount = !isShowAmount;
                  });
                },
                child: Icon(
                  isShowAmount ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xffA6A6A6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  menuIconList() {
    return Column(
      children: [
        GridView(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 0,
            crossAxisSpacing: 30,
            childAspectRatio: .5,
          ),
          shrinkWrap: true,
          children: List.generate(iconButton.length, (idx) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return directionMenuButton[idx];
                    }));
                  },
                  child: Container(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width / 20),
                    decoration: BoxDecoration(
                      color: DevColor.darkblue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(MediaQuery.of(context).size.width / 30),
                      ),
                    ),
                    child: Image.asset(
                      iconButton[idx],
                      width: MediaQuery.of(context).size.width / 15,
                      height: MediaQuery.of(context).size.width / 15,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 50,
                ),
                Text(
                  titleButton[idx],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 33,
                    color: DevColor.darkblue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }

  historyTransaction() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
      decoration: BoxDecoration(
          color: const Color(0xffF5F4F4),
          boxShadow: [
            BoxShadow(
              offset: const Offset(3, 4),
              blurRadius: 10.2,
              color: Colors.black.withOpacity(.15),
            )
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(MediaQuery.of(context).size.width / 60),
          )),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Transaksi Terakhir',
              style: DevTypograph.heading3.bold.copyWith(
                color: DevColor.darkblue,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 20,
            ),
            Obx(() {
              var recentTransactions =
                  transactionController.getRecentTransactions(3);
              if (recentTransactions.isNotEmpty) {
                return Column(
                  children: List.generate(recentTransactions.length, (index) {
                    var dataItemHistory = recentTransactions[index];
                    var dataHistory = UserTransferHistoryModel.fromJson(
                      dataItemHistory,
                    );
                    var currentRek = homeController.bankAccount.value;

                    String accountLabel = dataHistory.type == 'credit' &&
                            dataHistory.sourceRekening != currentRek.toString()
                        ? 'Dari Akun'
                        : '';

                    return cardListTransfer(
                      dataHistory.date,
                      dataHistory.amount,
                      dataHistory.type,
                      dataHistory.typeBank,
                      dataHistory.status,
                      accountLabel,
                    );
                  }),
                );
              }
              return const Text('Belum ada transaksi');
            }),
          ],
        ),
      ),
    );
  }

  Widget cardListTransfer(
    String transferDate,
    double amountTransfer,
    String typeTransfer,
    String bankTujuan,
    String status,
    String accountLabel,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: DevColor.darkblue,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              const SizedBox(height: 6),
              Text(
                transferDate.toFormattedDate(),
                style: DevTypograph.body1.medium.copyWith(
                  color: DevColor.darkblue,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                typeTransfer == 'debit'
                    ? '- ${amountTransfer.toRupiah()}'
                    : '+ ${amountTransfer.toRupiah()}',
                textScaler: const TextScaler.linear(0.8),
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
