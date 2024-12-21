import 'package:flutter/material.dart';

class AppColors {
  //* Main Colors (from CSS)
  static const Color primary = Color(0xff4e54c8); // Matches --primary-color
  static const Color secondary = Color(0xffDA4453); // Matches --secondary-color

  //* Background and Text Colors
  static const Color backgroundLight = Color(0xFFF8F8F8); // --background-color (light)
  static const Color backgroundDark = Color(0xff202020); // --background-color (dark mode)
  static const Color textLight = Color(0xff000000); // --text-color (light)
  static const Color textDark = Color(0xffffffff); // --text-color (dark mode)

  //* Additional Colors
  static const Color transparentColor = Color.fromRGBO(240, 166, 17, 0); // --transparent-color
  static const Color highlightColor = Color.fromRGBO(255, 170, 0, 0); // --highlight-color

  //* Shadow Color
  static const Color shadowEffect = Color.fromRGBO(0, 0, 0, 0.17); // For shadow or elevated elements

  //* button Color
  static const Color buttonColor = Color(0xFF11998E);
}
