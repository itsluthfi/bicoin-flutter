import 'package:flutter/material.dart';

import '../styles/typography.dart';

class DevTextField extends StatelessWidget {
  const DevTextField({
    super.key,
    required this.title,
    this.isPassword = false,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.styleTitle,
    this.styleValue,
    this.colorBorder,
    this.readOnly = false,
    this.onChanged,
    this.onTap,
  });

  final String title;
  final bool isPassword;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextStyle? styleTitle;
  final TextStyle? styleValue;
  final Color? colorBorder;
  final bool readOnly;
  final Function(String)? onChanged;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final passwordValue = ValueNotifier<bool>(isPassword);
    return ValueListenableBuilder(
      valueListenable: passwordValue,
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: styleTitle ?? DevTypograph.body1.bold,
            ),
            const SizedBox(height: 4),
            TextFormField(
              onChanged: onChanged,
              onTap: onTap,
              controller: controller,
              obscureText: passwordValue.value,
              keyboardType: keyboardType,
              readOnly: readOnly,
              style: styleValue ?? DevTypograph.body1.regular,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 18,
                ),
                hintText: 'Masukan ${title.toLowerCase()} anda',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: colorBorder ?? const Color(0XFF46BE8C),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: colorBorder ?? const Color(0XFF46BE8C),
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.red,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.red,
                  ),
                ),
                suffixIcon: isPassword
                    ? IconButton(
                        onPressed: () {
                          passwordValue.value = !passwordValue.value;
                        },
                        icon: Icon(
                          passwordValue.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: const Color(0XFF46BE8C),
                        ),
                      )
                    : null,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Masukan ${title.toLowerCase()} anda';
                }
                return null;
              },
            ),
          ],
        );
      },
    );
  }
}
