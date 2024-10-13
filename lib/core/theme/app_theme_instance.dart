import 'package:flutter/foundation.dart' show Brightness, PlatformDispatcher;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeInstance {
  AppThemeInstance._private();

  static final AppThemeInstance instance = AppThemeInstance._private();

  factory AppThemeInstance() => instance;

  ThemeData computeTheme({
    ThemeMode? mode,
    required Color seedColor,
  }) {
    final lightTheme = ThemeData(
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 18, color: Colors.black),
      ),
      colorSchemeSeed: seedColor,
      brightness: Brightness.light,
      useMaterial3: true,
      // pageTransitionsTheme: pageTransitionsTheme,
    );

    final darkTheme = ThemeData(
      fontFamily: GoogleFonts.roboto().fontFamily,
      appBarTheme: const AppBarTheme(
        // backgroundColor: ThemeMode.dark == mode ? Colors.green : Colors.greenAccent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 18,
        ),
      ),
      colorSchemeSeed: seedColor,
      brightness: Brightness.dark,
      useMaterial3: true,
      // pageTransitionsTheme: pageTransitionsTheme,
    );

    switch (mode) {
      case null:
        return lightTheme;
      case ThemeMode.light:
        return lightTheme;
      case ThemeMode.dark:
        return darkTheme;
      case ThemeMode.system:
        return PlatformDispatcher.instance.platformBrightness == Brightness.dark
            ? darkTheme
            : lightTheme;
    }
  }
}
