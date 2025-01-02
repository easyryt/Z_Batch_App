import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget button({String? title, onPressed, color, textColor}) {
  return SizedBox(
    height: 32,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: color),
        onPressed: onPressed,
        child: Text(
          title!,
          style: GoogleFonts.roboto(
            textStyle:   TextStyle(
               color: textColor,
                ),
          ),
        )),
  );
}
