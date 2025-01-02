import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pk_education/constant/constants.dart';

class PrimaryFilledButton extends StatefulWidget {
  final double width;
  final String buttonText;

  const PrimaryFilledButton({
    super.key,
    required this.width,
    required this.buttonText,
  });

  @override
  State<PrimaryFilledButton> createState() => _PrimaryFilledButtonState();
}

class _PrimaryFilledButtonState extends State<PrimaryFilledButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: widget.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Constants.primaryColor,
            Constants.primaryColor,
            Constants.primaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          widget.buttonText,
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
