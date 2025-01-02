import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pk_education/constant/constants.dart';

class PrimaryOutlinedButton extends StatefulWidget {
  final double width;
  final String buttonText;
  final IconData? icon;
  final bool hasIcon;

  const PrimaryOutlinedButton({
    super.key,
    required this.width,
    required this.buttonText,
    this.icon,
    this.hasIcon = false,
  });

  @override
  State<PrimaryOutlinedButton> createState() => _PrimaryOutlinedButtonState();
}

class _PrimaryOutlinedButtonState extends State<PrimaryOutlinedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: widget.width,
      decoration: BoxDecoration(
        border: Border.all(color: Constants.primaryColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.hasIcon
              ? Icon(
                  widget.icon,
                  color: Constants.primaryColor,
                  size: 20,
                )
              : const SizedBox(),
          widget.hasIcon ? const SizedBox(width: 8) : const SizedBox(),
          Text(
            widget.buttonText,
            style: GoogleFonts.roboto(
              color: Constants.primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
