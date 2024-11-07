// import 'dart:developer';
// import 'dart:io';

// import 'package:dev_coinku/core/styles/dev_color.dart';
// import 'package:flutter/material.dart';

// class IntroScreen extends StatefulWidget {
//   const IntroScreen({super.key});

//   @override
//   State<IntroScreen> createState() => _IntroScreenState();
// }

// class _IntroScreenState extends State<IntroScreen> {
//   // List<String> iconButtonIcon = [
//   //   'assets/icon/scan.png',
//   //   'assets/icon/wallet.png',
//   //   'assets/icon/cart.png',
//   // ];

//   // List<String> iconButtonTitle = [
//   //   'QRIS',
//   //   'e-Wallet',
//   //   'Pembelian',
//   // ];

//   @override
//   Widget build(BuildContext context) {
//     var dWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: DevColor.whiteColor,
//       body: loginForm(dWidth),
//     );
//   }

//   Widget loginForm(dWidth) {
//     return Container(
//       width: dWidth,
//       padding: EdgeInsets.fromLTRB(
//         dWidth / 8,
//         dWidth / 3,
//         dWidth / 8,
//         0,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Image.asset(
//             'assets/intro_logo.png',
//             fit: BoxFit.fitWidth,
//           ),
//           SizedBox(
//             height: dWidth / 20,
//           ),
//           Image.asset(
//             'assets/intro_illus.png',
//             fit: BoxFit.fitHeight,
//           ),
//           SizedBox(
//             height: dWidth / 10,
//           ),
//           SizedBox(
//             width: dWidth,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: DevColor.darkblue,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(
//                       dWidth,
//                     ),
//                   ),
//                 ),
//               ),
//               onPressed: () {
//                 // Navigator.push(context, MaterialPageRoute(builder: (context) {
//                 // return const LoginScreen();
//                 // }));
//               },
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: dWidth / 30),
//                 child: Text(
//                   'Login',
//                   style: Dev,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: dWidth / 10,
//           ),
//           // Row(
//           //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //   children: [
//           //     for (int i = 0; i < 3; i++) ...{
//           //       Column(
//           //         children: [
//           //           Container(
//           //             padding: EdgeInsets.all(dWidth / 25),
//           //             width: dWidth / 7,
//           //             decoration: BoxDecoration(
//           //               boxShadow: [
//           //                 BoxShadow(
//           //                   blurRadius: 4,
//           //                   offset: const Offset(0, 4),
//           //                   color: Colors.black.withOpacity(.25),
//           //                 )
//           //               ],
//           //               color: orange,
//           //               borderRadius: BorderRadius.all(
//           //                 Radius.circular(dWidth / 40),
//           //               ),
//           //             ),
//           //             child: Image.asset(
//           //               iconButtonIcon[i],
//           //             ),
//           //           ),
//           //           SizedBox(
//           //             height: dWidth / 30,
//           //           ),
//           //           Text(
//           //             iconButtonTitle[i],
//           //             style: smallBlackBoldText(context),
//           //           )
//           //         ],
//           //       ),
//           //     }
//           //   ],
//           // ),
//         ],
//       ),
//     );
//   }
// }
