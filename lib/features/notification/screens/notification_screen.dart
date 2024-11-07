import 'dart:developer';

import 'package:dev_coinku/core/styles/dev_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dashboard/home/controllers/home_controller.dart';

class NotificationScreen extends StatefulWidget {
  static const route = '/notification';
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final homeController = Get.put(HomeController());
  final Map<String, dynamic> arguments =
      Get.arguments as Map<String, dynamic>? ?? {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DevColor.darkblue,
        title: Text(arguments.toString()),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 24),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
                    decoration: BoxDecoration(
                      border: Border.all(color: DevColor.darkblue),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('notif $index'),
                  );
                },
              ),
            ),
            InkWell(
              onTap: someFunction,
              child: Container(
                height: 50,
                margin:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: BoxDecoration(
                  color: DevColor.darkblue,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Tandai semua telah terbaca',
                  style: TextStyle(color: DevColor.whiteColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void someFunction() async {
    try {
      await homeController.getRekeningUser();
    } catch (e) {
      log(e.toString());
    }
  }
}
