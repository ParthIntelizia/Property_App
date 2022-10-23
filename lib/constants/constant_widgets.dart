import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConstWidgets {
  Widget textWidget(
      String text, FontWeight fontWeight, double fontSize, Color color) {
    return Text(
      text,
      style: GoogleFonts.urbanist(
          fontWeight: fontWeight, fontSize: fontSize, color: color),
    );
  }



  Widget logo() {
    return Image.asset(
      "assets/logo.png",
      height: 65,
      width: 190,
    );
  }
}
