import 'package:flutter/material.dart';

class DevColor {
  static const Color primaryColor = Color(0XFF4ED0F9);
  static const Color secondaryColor = Color(0XFFFFDA7A);
  static const Color greenColor = Color(0XFF46BE8C);
  static const Color whiteColor = Color(0XFFFFFFFF);
  static const Color blackColor = Color(0XFF000000);
  static const Color greyColor = Color(0XFF9F9F9F);
  static const Color redColor = Color(0XFFFF0E0E);
  static const Color darkblue = Color(0xff0D4A71);
  static const Color orange = Color(0xffF57C00);

  static Color fromHex(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 6 || hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static String toHexColor(Color color) {
    return color.value.toRadixString(16);
  }
}
