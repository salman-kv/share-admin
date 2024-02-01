import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubAdminThme {
  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,

    textTheme: TextTheme(
      // large text like big heading
      bodyLarge: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      // small grey fonts
      bodySmall: GoogleFonts.poppins(
        fontWeight: FontWeight.normal,
        color: Colors.grey,
        fontSize: 18,
      ),
      // normal letters large
      displayLarge: GoogleFonts.poppins(
        // fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
      // normal letters meadium
      displayMedium: GoogleFonts.poppins(
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
      // normal letters small
      displaySmall: GoogleFonts.poppins(
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      // titile with bold large
      titleLarge:  GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      // titile with bold large
      titleMedium:  GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      // titile with bold large
      titleSmall:  GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
  );
  final ThemeData darkTheme = ThemeData(
    fontFamily: 'poppins',
    brightness: Brightness.dark,
       textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      bodySmall: GoogleFonts.poppins(
        fontWeight: FontWeight.normal,
        color: Colors.grey,
        fontSize: 16,
      ),
       // normal letters meadium
      displayMedium: GoogleFonts.poppins(
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
      // normal letters small
      displaySmall: GoogleFonts.poppins(
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
    ),
  );
}
