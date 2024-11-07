import 'package:flutter/material.dart';

import '../../core/styles/dev_color.dart';
import '../transactions/presentation/screens/history_transfer_screen.dart';
import 'home/screens/home_screen.dart';
import 'profile/screens/profile_screen.dart';

class NavigatorBar extends StatefulWidget {
  static const route = '/navigatorbar';
  const NavigatorBar({
    super.key,
  });

  @override
  State<NavigatorBar> createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  int currentIndex = 0;
  late int nominal;

  @override
  void initState() {
    nominal = 90;
    super.initState();
  }

  void onBarTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var dWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: [
        const HomeScreen(),
        const HistoryTransferScreen(),
        const ProfileScreen(),
      ][currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: DevColor.darkblue,
        currentIndex: currentIndex,
        onTap: onBarTapped,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: dWidth / 13,
            ),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history,
              size: dWidth / 13,
            ),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_2_rounded,
              size: dWidth / 13,
            ),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
