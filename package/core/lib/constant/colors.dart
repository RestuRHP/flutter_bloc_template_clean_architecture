import 'package:flutter/material.dart';

class AppColors {
  static Color primary = HexColor("#26ADE4");
  static Color darkPrimary = HexColor("#626166");

  static Color black = HexColor("#04021D");
  static Color grey = HexColor("#686777");
  static Color textGrey = HexColor("#808080");

  // Dark Color
  static Color darkGrey = HexColor("#626166");

  static Color white = HexColor("#FFFFFF");

  static Color lavenderGray = HexColor("#C1C5C9");
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
