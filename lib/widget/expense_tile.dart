import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget faqTile(String title, String description) {
  return ExpansionTile(
    shape: BeveledRectangleBorder(
        side: const BorderSide(color: Colors.grey, width: 0.5),
        borderRadius: BorderRadius.circular(4)),
    collapsedShape: BeveledRectangleBorder(
        side: const BorderSide(color: Colors.grey, width: 0.2),
        borderRadius: BorderRadius.circular(4)),
    dense: true,
    childrenPadding: const EdgeInsets.only(bottom: 8),
    tilePadding: const EdgeInsets.symmetric(horizontal: 8),
    title: Text(
      title,
      style: GoogleFonts.roboto(
        fontSize: 13.5,
        fontWeight: FontWeight.w500,
      ),
    ),
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        alignment: Alignment.centerLeft,
        child: Text(
          description,
          // textAlign: TextAlign.justify,
          style: GoogleFonts.roboto(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
            fontSize: 13,
          ),
        ),
      ),
    ],
  );
}
