import 'package:dev_coinku/features/notification/screens/notification_screen.dart';
import 'package:dev_coinku/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/services/fcm_service.dart';
import 'core/services/notification_service.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/auth/presentation/screens/register_screen.dart';
import 'features/dashboard/home/screens/home_screen.dart';
import 'features/dashboard/profile/screens/profile_screen.dart';
import 'features/splash/splash_screen.dart';
import 'features/dashboard/navbar_screen.dart';

void main() async {
  initializeDateFormatting();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'dev-coinku',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.initNotification();

  await GetStorage.init();

  await FcmService().initFCM();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        useMaterial3: false,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.route,
      routes: {
        SplashScreen.route: (ctx) => const SplashScreen(),
        LoginScreen.route: (ctx) => const LoginScreen(),
        RegisterScreen.route: (ctx) => const RegisterScreen(),
        NavigatorBar.route: (ctx) => const NavigatorBar(),
        HomeScreen.route: (ctx) => const HomeScreen(),
        ProfileScreen.route: (ctx) => const ProfileScreen(),
        NotificationScreen.route: (ctx) => const NotificationScreen(),
      },
    );
  }
}
