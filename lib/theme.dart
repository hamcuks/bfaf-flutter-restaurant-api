import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static Color green = Color(0xFF01B1AF);
  static Color scaffoldBackground = Color(0xFFFAFAFA);

  static TextStyle normalText = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );
  static TextStyle largeText = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.5,
  );
  static TextStyle mediumText = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );
}
