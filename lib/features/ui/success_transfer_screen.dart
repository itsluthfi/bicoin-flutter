// import 'package:dev_coinku/core/constant/color.dart';
// import 'package:dev_coinku/core/constant/text_style.dart';
// import 'package:dev_coinku/features/ui/navigator_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class SuccessTransferScreen extends StatefulWidget {
//   final String namaPenerima, bankTujuan, rekeningTujuan, metodeTransfer;
//   final int nominal;

//   const SuccessTransferScreen({
//     required this.namaPenerima,
//     required this.bankTujuan,
//     required this.rekeningTujuan,
//     required this.metodeTransfer,
//     required this.nominal,
//     super.key,
//   });

//   @override
//   State<SuccessTransferScreen> createState() => _SuccessTransferScreenState();
// }

// class _SuccessTransferScreenState extends State<SuccessTransferScreen> {
//   @override
//   Widget build(BuildContext context) {
//     var dWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: ListView(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(dWidth / 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Image.asset(
//                   'assets/coinku_white.png',
//                   scale: 2,
//                 ),
//                 SizedBox(
//                   height: dWidth / 20,
//                 ),
//                 Container(
//                   width: dWidth,
//                   padding: EdgeInsets.all(dWidth / 30),
//                   decoration: BoxDecoration(border: Border.all()),
//                   child: Column(
//                     children: [
//                       Icon(
//                         Icons.check_circle,
//                         color: blue,
//                         size: dWidth / 10,
//                       ),
//                       Text(
//                         'TRANSFER BERHASIL',
//                         style: bigBlueBoldText(context),
//                       ),
//                       SizedBox(
//                         height: dWidth / 20,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Rekening Tujuan',
//                             style: smallBlackBoldText(context),
//                           ),
//                           Text(
//                             widget.rekeningTujuan,
//                             style: smallBlackBoldText(context),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: dWidth / 30,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Nama Penerima',
//                             style: smallBlackBoldText(context),
//                           ),
//                           Text(
//                             widget.namaPenerima,
//                             style: smallBlackBoldText(context),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: dWidth / 30,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Tanggal Transaksi',
//                             style: smallBlackBoldText(context),
//                           ),
//                           Text(
//                             DateFormat('dd MMMM yyyy', 'ID')
//                                 .format(DateTime.now()),
//                             style: smallBlackBoldText(context),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: dWidth / 30,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Waktu Transaksi',
//                             style: smallBlackBoldText(context),
//                           ),
//                           Text(
//                             '${DateFormat('hh:mm:ss', 'ID').format(DateTime.now())} WIB',
//                             style: smallBlackBoldText(context),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: dWidth / 30,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Bank Tujuan',
//                             style: smallBlackBoldText(context),
//                           ),
//                           Text(
//                             widget.bankTujuan,
//                             style: smallBlackBoldText(context),
//                           ),
//                         ],
//                       ),
//                       widget.metodeTransfer != '-'
//                           ? Column(
//                               children: [
//                                 SizedBox(
//                                   height: dWidth / 30,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       'Metode Transfer',
//                                       style: smallBlackBoldText(context),
//                                     ),
//                                     Text(
//                                       widget.metodeTransfer,
//                                       style: smallBlackBoldText(context),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             )
//                           : const SizedBox(),
//                       SizedBox(
//                         height: dWidth / 30,
//                       ),
//                       const Divider(
//                         color: Colors.black,
//                         thickness: 1.0,
//                       ),
//                       SizedBox(
//                         height: dWidth / 30,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Nama Pengirim',
//                             style: smallBlackBoldText(context),
//                           ),
//                           Text(
//                             'Razita Aprilia',
//                             style: smallBlackBoldText(context),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: dWidth / 30,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Rekening Pengirim',
//                             style: smallBlackBoldText(context),
//                           ),
//                           Text(
//                             '****${'1234567890'.substring(7, 10)}',
//                             style: smallBlackBoldText(context),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: dWidth / 30,
//                       ),
//                       const Divider(
//                         color: Colors.black,
//                         thickness: 1.0,
//                       ),
//                       SizedBox(
//                         height: dWidth / 30,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Nominal',
//                             style: smallBlackBoldText(context),
//                           ),
//                           Text(
//                             'Rp. ${NumberFormat('#,##0', 'ID').format(widget.nominal)}',
//                             style: smallBlackBoldText(context),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: dWidth / 30,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Fee Transaksi',
//                             style: smallBlackBoldText(context),
//                           ),
//                           Text(
//                             'Rp. ${NumberFormat('#,##0', 'ID').format(widget.metodeTransfer == '-' ? 0 : 2500)}',
//                             style: smallBlackBoldText(context),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: dWidth / 30,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Total',
//                             style: smallBlackBoldText(context),
//                           ),
//                           Text(
//                             'Rp. ${NumberFormat('#,##0', 'ID').format(widget.nominal + (widget.metodeTransfer == '-' ? 0 : 2500))}',
//                             style: smallBlackBoldText(context),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: dWidth / 10,
//                 ),
//                 SizedBox(
//                   width: dWidth,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: blue,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.all(
//                           Radius.circular(dWidth / 20),
//                         ))),
//                     onPressed: () {
//                       // Navigator.of(context).pushAndRemoveUntil(
//                       //     MaterialPageRoute(
//                       //         builder: (context) => NavigatorBar(
//                       //               nominalTerkirim: widget.nominal,
//                       //             )),
//                       //     (Route<dynamic> route) => false);
//                     },
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(vertical: dWidth / 30),
//                       child: Text(
//                         'Kembali ke menu',
//                         style: mediumWhiteBoldText(context),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
