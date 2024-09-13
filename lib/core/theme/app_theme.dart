import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
final class AppTheme {
  AppTheme({
    this.mode = ThemeMode.system,
    required this.seed,
  })  : darkTheme = ThemeData(
          colorSchemeSeed: seed,
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        lightTheme = ThemeData(
          colorSchemeSeed: seed,
          brightness: Brightness.light,
          useMaterial3: true,
        );

  /// The type of theme to use.
  final ThemeMode mode;

  /// The seed color to generate the [ColorScheme] from.
  final Color seed;

  static AppTheme defaultTheme =
      AppTheme(mode: ThemeMode.light, seed: Colors.blue);

  /// The light [ThemeData] for this [AppTheme].
  final ThemeData lightTheme;

  /// The dark [ThemeData] for this [AppTheme].
  final ThemeData darkTheme;

  /// This returns the calculated [ThemeData] for this [AppTheme]
  ThemeData get theme => computeTheme();

  /// This [ThemeData] computed based on the [mode].
  ThemeData computeTheme() {
    switch (mode) {
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
