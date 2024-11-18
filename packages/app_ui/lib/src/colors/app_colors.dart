import 'package:flutter/material.dart';

/// Defines the color palette for the App UI Kit.
abstract class AppColors {
  /// Black
  static const Color black = Color(0xFF000000);

  /// The background color.
  static const Color background = Color.fromARGB(255, 32, 30, 30);

  /// White
  static const Color white = Color(0xFFFFFFFF);

  /// Transparent
  static const Color transparent = Color(0x00000000);

  /// The light blue color.
  static const Color lightBlue = Color.fromARGB(255, 100, 181, 246);

  /// The blue primary color and swatch.
  static const Color blue = Color(0xFF3898EC);

  /// The deep blue color.
  static const Color deepBlue = Color(0xff337eff);

  /// The green color.
  static const MaterialColor green = Colors.green;

  /// The orange accent color.
  static const Color orangeAccent = Color.fromARGB(255, 230, 81, 0);

  /// The primary orange color.
  static const Color orange = Color.fromARGB(255, 239, 108, 0);

  /// The border outline color.
  static const Color borderOutline = Color.fromARGB(165, 58, 58, 58);

  /// Light dark.
  static const Color lightDark = Color.fromARGB(164, 120, 119, 119);

  /// Dark.
  static const Color dark = Color.fromARGB(255, 58, 58, 58);

  /// Primary dark blue color.
  static const Color primaryDarkBlue = Color(0xff1c1e22);

  /// Grey.
  static const Color grey = Colors.grey;

  /// The bright grey color.
  static const Color brightGrey = Color.fromARGB(255, 238, 238, 238);

  /// The dark grey color.
  static const Color darkGrey = Color.fromARGB(255, 66, 66, 66);

  /// The emphasize grey color.
  static const Color emphasizeGrey = Color.fromARGB(255, 97, 97, 97);

  /// The emphasize dark grey color.
  static const Color emphasizeDarkGrey = Color.fromARGB(255, 40, 37, 37);

  /// Red material color.
  static const MaterialColor red = Colors.red;

  /// old
  static const Color colorPrimary = Color(0xFF000000);
  static const Color textFieldBorderColor = Color(0x1B9F9FA5);
  static const Color selectedBlue = Color(0xff007AFF);

  static const Color forgetPasswordBlueColor = Color(0xFF273782);
  static const Color inputTextFieldBorderGray = Color(0xFFD1D1D6);
  static const Color hintTextGrey = Color(0xFF3C3C43);

  // app error
  static const Color errorRed = Color(0xFFD0021B);

  // large advertisement cart
  static const Color advertisementCardBG = Color(0xfff2f2f7);

  static const priceColor = Colors.blueAccent;
  static const ratingColor = Color(0xffff9500);

  // product details widget
  static const priceColor2 = Color(0xff273782);
  static const locationColor = Color(0xff8a8a8e);

  // dropdown color
  static const Color dropDownGrey = Color(0xff8a8a8e);
  static const Color dropDownBorder = Color(0xffb3b3b3);

  // chip
  static const Color chipGrey = Color(0xFF8A8A8E);
  static const Color chipSelectedBg = Color(0xFFD9EBFF);

  // property and Vehicle card bottom section chip color
  // purple color here
  static const Color purpleOverlay = Color(0x4D6A0DAD);

  // app shimmer colors.
  static const Color baseColor =
      Color(0xFFE0E0E0); // Equivalent to Colors.grey.shade300
  static const Color highlightColor =
      Color(0xFFF5F5F5); // Equivalent to Colors.grey.shade100
  static const Color blueGray =
      Color(0xFFF2F2F7); // Equivalent to Colors.grey.shade100
}
