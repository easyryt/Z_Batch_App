import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:pinput/pinput.dart';
import 'package:pk_education/constant/constants.dart';
import 'package:pk_education/controller/pk/auth_register_controller.dart';
import 'package:pk_education/controller/pk/main_app_controller.dart';
import 'package:pk_education/screens/bottom_navigation.dart';
import 'package:pk_education/services/global.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final AuthRegisterController authController =
      Get.put(AuthRegisterController());
  final MainApplicationController mainApplicationController = Get.find();
  late OTPTextEditController otpController;
  late OTPInteractor _otpInteractor;
  late Timer _resendTimer;
  int _resendSeconds = 30;

  globalInit() async {
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
  }

  @override
  void initState() {
    super.initState();
    globalInit();
    _initOTPInteractor();
    otpController = OTPTextEditController(
      codeLength: 4,
      onCodeReceive: (code) {
        setState(() {
          otpController.text = code;
        });
        // Get.snackbar("OTP Received", "OTP Auto-filled: $code",
        //     snackPosition: SnackPosition.TOP);
      },
    )..startListenUserConsent(
        (code) {
          final exp = RegExp(r'\d{4}');
          return exp.stringMatch(code ?? '') ?? '';
        },
      );
  }

  Future<void> _initOTPInteractor() async {
    _otpInteractor = OTPInteractor();
    final appSignature = await _otpInteractor.getAppSignature();
    // debugPrint('Your app signature: $appSignature');
  }

  @override
  void dispose() {
    super.dispose();
    authController.otpTextEditingController.dispose();
    authController.phoneTextEditingController.dispose();
    otpController.stopListen();
    _resendTimer.cancel();
  }

  void startResendTimer() {
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendSeconds > 0) {
          _resendSeconds--;
        } else {
          _resendTimer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(builder: (context, constraints) {
        final isKeyboardOpen = constraints.maxHeight < size.height * 0.9;
        return Stack(
          children: [
            // SizedBox(
            //   height: size.height,
            //   child: SizedBox(
            //     height: size.height * 0.42,
            //     // width: size.width,
            //     // child: Image.asset(
            //     //   "assets/images/thumbnail.png",
            //     //   //  fit: BoxFit.cover,
            //     // ),
            //   ),
            // ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Obx(() {
                return Container(
                  decoration: const BoxDecoration(
                      // color: Colors.white,
                      ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          authController.sentOtp.value
                              ? "OTP VERIFICATION"
                              : "Registration",
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (!authController.sentOtp.value)
                          SizedBox(
                            height: size.height * 0.006,
                          ),
                        if (!authController.sentOtp.value)
                          Text(
                            "We'll send you an One Time Password by SMS ",
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                color: Colors.black45,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        if (!authController.sentOtp.value)
                          Text(
                            "to confirm your mobile number",
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                color: Colors.black45,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        SizedBox(
                            height: isKeyboardOpen
                                ? size.height * 0.02
                                : size.height * 0.05),
                        Text(
                          "Enter Mobile Number ",
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Form(
                          key: formKey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: (authController.isError.value)
                                        ? 20
                                        : 0),
                                child: Column(
                                  children: [
                                    Text(
                                      "+91",
                                      style: GoogleFonts.roboto(
                                        textStyle: const TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 12),
                                      height: 1.2,
                                      width: 20,
                                      color: authController.sentOtp.value
                                          ? Colors.grey[300]
                                          : const Color(0xFFAEAEAE),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 8),
                                width: 150,
                                child: GestureDetector(
                                  onTap: () {
                                    if (authController.sentOtp.value) {
                                      authController.sentOtp.value = false;
                                      otpController.clear();
                                      authController.otpTextEditingController
                                          .clear();
                                    }
                                  },
                                  child: TextFormField(
                                    autofocus: true,
                                    controller: authController
                                        .phoneTextEditingController,
                                    //  autofocus: true,
                                    keyboardType: TextInputType.number,
                                    enabled: authController.sentOtp.value
                                        ? false
                                        : true,
                                    maxLength: 10,
                                    style: GoogleFonts.roboto(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12),
                                        counterText: "",
                                        hintText: 'Enter Number',
                                        hintStyle: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            color: Color(0xFFD2CCCC),
                                            fontSize: 12,
                                          ),
                                        ),
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFFAEAEAE),
                                                    width: 1.2)),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFFAEAEAE),
                                                    width: 1.2))),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        setState(() {
                                          authController.isError.value = true;
                                        });

                                        return " Please Input Number";
                                      } else if (value.length != 10) {
                                        setState(() {
                                          authController.isError.value = true;
                                        });
                                        return "Input Valid Number";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: isKeyboardOpen
                                ? size.height * 0.03
                                : size.height * 0.05),
                        if (authController.sentOtp.value)
                          Text(
                            "Enter OTP ",
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        if (authController.sentOtp.value)
                          Pinput(
                            autofocus: true,
                            //  controller: authController.otpTextEditingController,
                            controller: otpController,
                            length: 4,
                            showCursor: true,
                            defaultPinTheme: PinTheme(
                              width: 40,
                              height: 40,
                              textStyle: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Color(0xFFAEAEAE), width: 0.8)),
                              ),
                            ),
                            onChanged: (value) async {
                              if (otpController.length == 4) {
                                authController.otpTextEditingController.text =
                                    otpController.text;
                                var token = await authController.verifyOtp();
                                if (token != null && token != "") {
                                  Global.storageServices.setString(
                                      "phoneNumber",
                                      authController
                                          .phoneTextEditingController.text);
                                  Global.storageServices
                                      .setString("x-student-token", token);
                                  Global.apiClient.updateHeader(token);
                                  Get.to(() => const MainHomeScreen());
                                } else {
                                  Get.snackbar(
                                      "error", "Please input a valid otp",
                                      snackPosition: SnackPosition.BOTTOM);
                                }
                              }
                            },
                            onTap: () {
                              if (otpController.length == 4 ||
                                  otpController.length > 4) {
                                otpController.clear();
                                authController.otpTextEditingController.clear();
                              }
                            },
                            onCompleted: (pin) {},
                          ),
                        SizedBox(
                            height: isKeyboardOpen
                                ? size.height * 0.03
                                : size.height * 0.04),
                        if (authController.sentOtp.value)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                " ${(_resendSeconds ~/ 60).toString().padLeft(2, '0')}:${(_resendSeconds % 60).toString().padLeft(2, '0')}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  color: (_resendSeconds > 0)
                                      ? Constants.primaryColor
                                      : Colors.grey[300],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                onTap: () async {
                                  authController.otpTextEditingController
                                      .clear();
                                  if (_resendSeconds == 0) {
                                    if (formKey.currentState!.validate()) {
                                      bool isGetOtp =
                                          await authController.getOtp();
                                      if (isGetOtp) {
                                        setState(() {
                                          startResendTimer();
                                        });
                                        // Get.snackbar("wow",
                                        //     "Otp Sending Successfully ${authController.otpTextEditingController.text}",
                                        //     snackPosition: SnackPosition.TOP);
                                      } else {
                                        Get.snackbar(
                                            "error", "Otp Sending Failed",
                                            snackPosition:
                                                SnackPosition.BOTTOM);
                                      }
                                    }
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          color: (_resendSeconds == 0)
                                              ? Constants.primaryColor
                                              : Colors.grey.shade300,
                                          width: 1)),
                                  child: Text(
                                    "Resend OTP",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: (_resendSeconds == 0)
                                          ? Constants.primaryColor
                                          : Colors.grey[400],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        if (authController.sentOtp.value)
                          SizedBox(
                              height: isKeyboardOpen
                                  ? size.height * 0.03
                                  : size.height * 0.05),
                        authController.isLoading.value
                            ? const Center(child: CircularProgressIndicator())
                            : InkWell(
                                onTap: () async {
                                  authController.otpTextEditingController.text =
                                      otpController.text;
                                  if ((!authController.sentOtp.value)) {
                                    if (formKey.currentState!.validate()) {
                                      bool isGetOtp =
                                          await authController.getOtp();
                                      if (isGetOtp) {
                                        setState(() {
                                          startResendTimer();
                                        });
                                        // Get.snackbar(
                                        //     "wow", "Otp Sending Successfully",
                                        //     snackPosition: SnackPosition.TOP);
                                      } else {
                                        Get.snackbar(
                                            "error", "Otp Sending Failed",
                                            snackPosition:
                                                SnackPosition.BOTTOM);
                                      }
                                    }
                                  } else {
                                    if (authController.otpTextEditingController
                                            .text.length ==
                                        4) {
                                      var token =
                                          await authController.verifyOtp();
                                      if (token != null && token != "") {
                                        Global.storageServices.setString(
                                            "phoneNumber",
                                            authController
                                                .phoneTextEditingController
                                                .text);
                                        Global.storageServices.setString(
                                            "x-student-token", token);
                                        Global.apiClient.updateHeader(token);
                                        Get.to(() => const MainHomeScreen());
                                      }
                                    } else {
                                      Get.snackbar("error", "input 4 digit otp",
                                          snackPosition: SnackPosition.BOTTOM);
                                    }
                                  }
                                },
                                child: Container(
                                  width: size.width,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: Constants.primaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      (!authController.sentOtp.value)
                                          ? 'Send Otp'
                                          : 'Proceed',
                                      style: GoogleFonts.roboto(
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        if (!isKeyboardOpen)
                          SizedBox(
                            height: size.height * 0.05,
                          )
                      ],
                    ),
                  ),
                );
              }),
            )
          ],
        );
      }),
    );
  }
}
