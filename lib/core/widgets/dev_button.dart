import 'package:dev_coinku/core/styles/dev_color.dart';
import 'package:flutter/material.dart';

import '../styles/typography.dart';

class DevButton extends StatelessWidget {
  const DevButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.radius = 12,
    this.colorButton = DevColor.darkblue,
    this.colorText = DevColor.whiteColor,
  });
  final String title;
  final VoidCallback onPressed;
  final double radius;
  final Color colorButton;
  final Color colorText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: colorButton,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          title,
          style: DevTypograph.body2.bold.copyWith(
            color: colorText,
          ),
        ),
      ),
    );
  }
}
