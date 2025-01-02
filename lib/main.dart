import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pk_education/constant/constants.dart';
import 'package:pk_education/controller/pk/main_app_controller.dart';
import 'package:pk_education/screens/auth/splash_screen.dart';
import 'package:pk_education/services/global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Global.init();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Constants.primaryColor,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  MainApplicationController mainApplicationController =
      Get.put(MainApplicationController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'NPC_Classes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFD0000)),
        useMaterial3: true,
        fontFamily: GoogleFonts.roboto().fontFamily,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
