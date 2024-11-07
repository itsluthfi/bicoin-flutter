import 'package:flutter/material.dart';

import '../../../../core/styles/dev_color.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final dWidth = MediaQuery.of(context).size.width;

    return AppBar(
      elevation: 0,
      backgroundColor: DevColor.darkblue,
      toolbarHeight: dWidth / 5,
      title: Image.asset(
        'assets/coinku.png',
        scale: 2.2,
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(dWidth / 5),
        child: const SizedBox(),
      ),
    );
  }
}
