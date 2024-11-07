import 'package:dev_coinku/core/styles/dev_color.dart';
import 'package:flutter/material.dart';

class DevPopup {
  static Future<void> loading(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return Center(
          child: CircularProgressIndicator(
            color: DevColor.primaryColor,
          ),
        );
      },
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }
}
