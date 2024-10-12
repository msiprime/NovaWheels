import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nova_wheels/config/bloc/global_bloc_providers.dart';
import 'package:nova_wheels/core/base_component/base/base_bloc/base_bloc.dart';
import 'package:nova_wheels/core/base_component/base/base_bloc/base_state.dart';
import 'package:nova_wheels/core/localization.dart';
import 'package:nova_wheels/core/routes/route_generator.dart';
import 'package:nova_wheels/core/theme/color_schema.dart';
import 'package:nova_wheels/shared/utils/transitions.dart';
import 'package:nova_wheels/shared/values/app_colors.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: GlobalBlocProviders().providers,
      child: BlocBuilder<BaseBloc, BaseState>(
        builder: (context, state) {
          return MaterialApp.router(
            supportedLocales: getSupportedLocal(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            locale: state.locale,
            debugShowCheckedModeBanner: false,
            themeMode: state.themeMode,
            theme: _buildThemeData(),
            darkTheme: _buildDarkThemeData(),
            routerConfig: RouteGenerator.router,
          );
        },
      ),
    );
  }

  ThemeData _buildDarkThemeData() {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        actionsIconTheme: IconThemeData(color: AppColorsMain.selectedBlue),
        iconTheme: IconThemeData(color: AppColorsMain.selectedBlue),
      ),
      useMaterial3: true,
      colorScheme: darkColorScheme,
      pageTransitionsTheme: pageTransitionsTheme,
    );
  }

  ThemeData _buildThemeData() {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        actionsIconTheme: IconThemeData(color: AppColorsMain.selectedBlue),
        iconTheme: IconThemeData(color: AppColorsMain.selectedBlue),
      ),
      useMaterial3: true,
      colorScheme: lightColorScheme,
      // fontFamily: "SFProDisplay",
      pageTransitionsTheme: pageTransitionsTheme,
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        visualDensity: VisualDensity.compact,
        selectedTileColor: AppColorsMain.selectedBlue,
        iconColor: AppColorsMain.grey,
        // textColor: AppColors.selectedBlue,
      ),
    );
  }
}
