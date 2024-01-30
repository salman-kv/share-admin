import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_sub_admin/presentation/cosnt/const_colors.dart';

class DesignedText {
  welcomeShareText(BuildContext context) {
    return Column(
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(
            text: 'S',
            style: GoogleFonts.poppins(
              color: ConstColors().mainColorpurple,
              fontSize: 60,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: 'hare',
            style: GoogleFonts.poppins(
              color:
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
        ])),
      ],
    );
  }
}
