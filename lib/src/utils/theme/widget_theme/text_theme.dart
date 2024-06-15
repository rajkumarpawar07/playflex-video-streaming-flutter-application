import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/colors.dart';

class TTextTheme {
  TTextTheme._(); // to avoid creating instances

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: GoogleFonts.montserrat(
        fontSize: 28.0, fontWeight: FontWeight.bold, color: tDarkColor),
    headlineMedium: GoogleFonts.montserrat(
        fontSize: 24.0, fontWeight: FontWeight.w700, color: tDarkColor),
    headlineSmall: GoogleFonts.poppins(
        fontSize: 24.0, fontWeight: FontWeight.w700, color: tDarkColor),
    bodySmall: GoogleFonts.poppins(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: tDarkColor),
    bodyLarge: GoogleFonts.poppins(
        fontSize: 14.0, fontWeight: FontWeight.w600, color: tDarkColor),
    bodyMedium: GoogleFonts.poppins(
        fontSize: 14.0, fontWeight: FontWeight.normal, color: tDarkColor),
    titleLarge: GoogleFonts.poppins(
        fontSize: 14.0, fontWeight: FontWeight.normal, color: tDarkColor),
    // bodyMedium: GoogleFonts.poppins(
    //   color: Colors.black,
    // ),
    // bodyLarge: GoogleFonts.poppins(
    //   color: Colors.black,
    //   fontWeight: FontWeight.bold,
    // ),
    // titleLarge: GoogleFonts.poppins(
    //     fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: GoogleFonts.montserrat(
        fontSize: 28.0, fontWeight: FontWeight.bold, color: tWhiteColor),
    headlineMedium: GoogleFonts.montserrat(
        fontSize: 24.0, fontWeight: FontWeight.w700, color: tWhiteColor),
    headlineSmall: GoogleFonts.poppins(
        fontSize: 24.0, fontWeight: FontWeight.w700, color: tWhiteColor),
    bodySmall: GoogleFonts.poppins(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: tWhiteColor),
    bodyLarge: GoogleFonts.poppins(
        fontSize: 14.0, fontWeight: FontWeight.w600, color: tWhiteColor),
    bodyMedium: GoogleFonts.poppins(
        fontSize: 14.0, fontWeight: FontWeight.normal, color: tWhiteColor),
    titleLarge: GoogleFonts.poppins(
        fontSize: 14.0, fontWeight: FontWeight.normal, color: tWhiteColor),
    // bodyMedium: GoogleFonts.poppins(
    //   color: Colors.white,
    // ),
    // bodyLarge: GoogleFonts.poppins(
    //   color: Colors.white,
    //   fontWeight: FontWeight.bold,
    // ),
    // titleLarge: GoogleFonts.poppins(
    //     fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
  );
}
