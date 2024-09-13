import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);

  Size get mediaQuery => MediaQuery.sizeOf(this);

  double get height => mediaQuery.height;

  double get width => mediaQuery.width;

  AppLocalizations? get localization => AppLocalizations.of(this);
}
