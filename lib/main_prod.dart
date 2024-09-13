import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_start/config/environment/build_config.dart';
import 'package:quick_start/config/environment/env_config.dart';
import 'package:quick_start/config/environment/environment.dart';
import "package:quick_start/config/sl/injection_container.dart" as di;
import 'package:quick_start/core/application/my_app.dart';
import 'package:quick_start/shared/local_storage/cache_service.dart';
import 'package:quick_start/shared/utils/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeMode = await CacheService.instance.retrieveTheme();
  final local = await CacheService.instance.retrieveLanguage();
  EnvConfig prodConfig = EnvConfig(
    appName: "Production",
    baseUrl: "https://api-dev.bionippy.com/api/",
    themeMode: themeMode == 'light' ? ThemeMode.light : ThemeMode.dark,
    locale: local == 'en' ? const Locale('en') : const Locale('bn'),
  );

  BuildConfig.instantiate(
    envType: Environment.production,
    envConfig: prodConfig,
  );
  Bloc.observer = GlobalBlocObserver();
  await di.init();

  runApp(const Application());
}
