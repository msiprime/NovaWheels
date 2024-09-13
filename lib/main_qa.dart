import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/config/environment/build_config.dart';
import 'package:nova_wheels/config/environment/env_config.dart';
import 'package:nova_wheels/config/environment/environment.dart';
import 'package:nova_wheels/config/sl/injection_container.dart' as di;
import 'package:nova_wheels/core/application/my_app.dart';
import 'package:nova_wheels/shared/local_storage/cache_service.dart';
import 'package:nova_wheels/shared/utils/bloc_observer.dart';

Future<void> main() async {
  final themeMode = await CacheService.instance.retrieveTheme();
  final local = await CacheService.instance.retrieveLanguage();
  EnvConfig qaConfig = EnvConfig(
      appName: "QA",
      baseUrl: "xyz",
      themeMode: themeMode == 'light' ? ThemeMode.light : ThemeMode.dark,
      locale: local == 'en' ? const Locale('en') : const Locale('bn'));

  BuildConfig.instantiate(
    envType: Environment.qa,
    envConfig: qaConfig,
  );
  Bloc.observer = GlobalBlocObserver();
  await di.init();

  runApp(const Application());
}
