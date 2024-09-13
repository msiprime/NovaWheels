import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nova_wheels/config/bloc/global_bloc_providers.dart';
import 'package:nova_wheels/core/base_component/base/base_bloc/base_bloc.dart';
import 'package:nova_wheels/core/base_component/base/base_bloc/base_state.dart';
import 'package:nova_wheels/core/localization.dart';
import 'package:nova_wheels/core/routes/route_generator.dart';
import 'package:nova_wheels/core/theme/color.schema.dart';
import 'package:nova_wheels/shared/utils/transitions.dart';

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
            theme: ThemeData(
                useMaterial3: true,
                colorScheme: lightColorScheme,
                pageTransitionsTheme: pageTransitionsTheme),
            darkTheme: ThemeData(
                useMaterial3: true,
                colorScheme: darkColorScheme,
                pageTransitionsTheme: pageTransitionsTheme),
            routerConfig: RouteGenerator.router,
          );
        },
      ),
    );
  }
}

//import 'package:flutter/material.dart';
//
// import '../routes/route_generator.dart';
// import '../theme/app_theme.dart';
//
// class Application extends StatelessWidget {
//   Application({super.key});
//
//   ///Initialize [AppTheme] with [seed] color
//   final AppTheme _appTheme = AppTheme(seed: const Color(0xFF664BC9));
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       routerConfig: RouteGenerator.router,
//       theme: _appTheme.theme,
//     );
//   }
// }
