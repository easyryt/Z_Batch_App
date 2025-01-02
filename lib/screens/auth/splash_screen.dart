import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pk_education/controller/pk/main_app_controller.dart';
import 'package:pk_education/screens/auth/register_screen.dart';
import 'package:pk_education/screens/bottom_navigation.dart';
import 'package:pk_education/services/global.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  MainApplicationController mainApplicationController =
      Get.put(MainApplicationController());

  @override
  void initState() {
    checkFirstSeen();
    super.initState();
  }

  checkFirstSeen() async {
    if (Global.storageServices.getString("x-student-token") != null) {
      print(Global.storageServices.getString("x-student-token"));
      await Global.apiClient
          .updateHeader(Global.storageServices.getString("x-student-token"));
      if (Global.storageServices.getString("selectedClassName") != "" &&
          Global.storageServices.getString("selectedClassName") !=
              "Select Your Class" &&
          Global.storageServices.getString("selectedClassName") != null) {
        mainApplicationController.className.value =
            Global.storageServices.getString("selectedClassName") ??
                "Select Your Class";
        mainApplicationController.classId.value =
            Global.storageServices.getString("selectedClassId") ?? "";
      }
      Timer(const Duration(milliseconds: 500), () async {
        Get.offAll(() => const MainHomeScreen());
      });
    } else {
      Timer(const Duration(milliseconds: 500), () async {
        Get.offAll(() => const RegisterScreen());
        //  Get.offAll(() => const RegisterScreen());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size.width * 0.6,
              height: size.height * 0.36,
              decoration: ShapeDecoration(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size.height * 0.8))),
              // child: const Image(
              //   image: AssetImage("assets/images/logo.png"),
              //   fit: BoxFit.contain,
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
