import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pk_education/constant/constants.dart';
import 'package:pk_education/services/global.dart';

class AuthRegisterController extends GetxController {
  var sentOtp = false.obs;
  var isLoading = false.obs;
  var isError = false.obs;
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController otpTextEditingController = TextEditingController();

  getOtp() async {
    isError.value = false;
    isLoading.value = true;
    Dio.Response response = await Global.apiClient.postData(
      Constants.generateOtpEndPoint,
      {
        "phone": phoneTextEditingController.text,
      },
      null,
    );
    isLoading.value = false;
    if (response.statusCode == 200) {
      otpTextEditingController.text = response.data["otp"];
      Get.snackbar("Otp", " Your Otp is ${response.data["otp"]}",
          snackPosition: SnackPosition.TOP);
      sentOtp.value = true;
      return true;
    } else {
      return false;
    }
  }

  verifyOtp() async {
    isLoading.value = true;
    Map<String, dynamic> body;

    body = {
      "phone": phoneTextEditingController.text,
      "otp": otpTextEditingController.text,
    };

    Dio.Response response = await Global.apiClient.postData(
      Constants.verifyOtpEndPoint,
      body,
      null,
    );
    isLoading.value = false;
    if (response.statusCode == 200) {
      // await saveTokenToSharedPreferences(response.data["token"]);
      return response.data["token"];
    } else {
      return "";
    }
  }
}
