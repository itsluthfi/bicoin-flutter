import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:dev_coinku/core/styles/dev_color.dart';
import 'package:dev_coinku/core/styles/typography.dart';

class DevDropdownSearchForm extends StatelessWidget {
  const DevDropdownSearchForm({
    super.key,
    required this.title,
    required this.dataItems,
    this.hint,
    this.styleTitle,
    this.onSaved,
    this.onChanged,
    this.colorBorder,
    this.isDisabled = false,
    this.dropDownKey,
    this.controller,
  });

  final String title;
  final List<String> dataItems;
  final String? hint;
  final TextStyle? styleTitle;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final Color? colorBorder;
  final bool isDisabled;
  final GlobalKey<FormFieldState>? dropDownKey;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    List<String> uniqueItems = dataItems.toSet().toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: DevTypograph.body1.bold,
        ),
        const SizedBox(height: 4),
        DropdownSearch<String>(
          key: dropDownKey,
          enabled: !isDisabled,
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              enabled: !isDisabled,
              filled: true,
              fillColor: isDisabled
                  ? DevColor.greyColor.withOpacity(0.15)
                  : Colors.transparent,
              hintStyle: DevTypograph.body1.regular,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  color: DevColor.greyColor.withOpacity(0.5),
                ),
              ),
            ),
          ),
          popupProps: PopupProps.menu(
            showSearchBox: true,
            showSelectedItems: true,
            disabledItemFn: (String s) => s == 'Disabled Item',
            searchFieldProps: TextFieldProps(
              controller: controller,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: isDisabled
                    ? DevColor.greyColor.withOpacity(0.15)
                    : Colors.transparent,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: DevColor.greyColor.withOpacity(0.5),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: DevColor.fromHex("#005880"),
                  ),
                ),
                hintText: 'Search...',
              ),
            ),
          ),
          dropdownBuilder: (context, selectedItem) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                selectedItem ?? hint ?? 'Pilh bank tujuan',
                style: DevTypograph.body1.light.copyWith(
                  color: uniqueItems.contains(selectedItem)
                      ? null
                      : DevColor.blackColor.withOpacity(0.6),
                ),
              ),
            );
          },
          items: uniqueItems.toList(),
          validator: (value) {
            log('Item selected: $value');
            if (value == null) {
              return 'Pilh bank tujuan $title';
            }
            return null;
          },
          onChanged: onChanged,
          onSaved: onSaved,
        ),
      ],
    );
  }
}
