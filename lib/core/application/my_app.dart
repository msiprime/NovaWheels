import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nova_wheels/config/bloc/global_bloc_providers.dart';
import 'package:nova_wheels/core/base_component/base/base_bloc/base_bloc.dart';
import 'package:nova_wheels/core/base_component/base/base_bloc/base_state.dart';
import 'package:nova_wheels/core/localization.dart';
import 'package:nova_wheels/core/routes/route_generator.dart';
import 'package:nova_wheels/core/theme/app_theme_instance.dart';

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
            theme: AppThemeInstance.instance.computeTheme(
              mode: state.themeMode,
              seedColor: Colors.teal,
            ),
            routerConfig: RouteGenerator.router,
          );
        },
      ),
    );
  }
}
