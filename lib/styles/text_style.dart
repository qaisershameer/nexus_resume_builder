import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle get appBarTextStyles {
  return GoogleFonts.montserrat(
      textStyle: const TextStyle(
    fontSize: 20,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ));
}

TextStyle get headingTextStyles {
  return GoogleFonts.montserrat(
      textStyle: const TextStyle(
    fontSize: 25,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ));
}

TextStyle get subHeadingTextStyles {
  return GoogleFonts.montserrat(
      textStyle: TextStyle(
    fontSize: 16,
    height: 1.6,
    color: Colors.grey.shade500,
  ));
}

TextStyle get labelTextStyles {
  return GoogleFonts.montserrat(
      textStyle: const TextStyle(
    color: Colors.white,
  ));
}

TextStyle get hintTextStyles {
  return GoogleFonts.montserrat(
      textStyle: const TextStyle(
    color: Colors.white,
  ));
}

TextStyle get inputTextStyles {
  return GoogleFonts.montserrat(
      textStyle: const TextStyle(
        color: Colors.white,
      ));
}
