import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pk_education/constant/constants.dart';

class CustomToasts {
  static void showToast(BuildContext context, String text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(minutes: 20),
      ),
    );
  }

  static void errorToast(BuildContext context, String text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
        // margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_amber,
              color: Constants.primaryColor,
              size: 18,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: Constants.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  static void successToast(BuildContext context, String text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.check,
              color: Colors.green,
              size: 18,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.roboto(
                  fontSize: 17,
                  color: Constants.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }
}
