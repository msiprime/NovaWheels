import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:nova_wheels/config/environment/build_config.dart';
import 'package:nova_wheels/config/environment/env_config.dart';
import 'package:nova_wheels/config/environment/environment.dart';
import "package:nova_wheels/config/sl/injection_container.dart" as di;
import 'package:nova_wheels/config/supabase/secret/app_secrets.dart';
import 'package:nova_wheels/core/application/my_app.dart';
import 'package:nova_wheels/shared/local_storage/cache_service.dart';
import 'package:nova_wheels/shared/utils/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Gemini.init(apiKey: AppSecrets.geminiApiKey);

  final themeMode = await CacheService.instance.retrieveTheme();
  final local = await CacheService.instance.retrieveLanguage();
  EnvConfig prodConfig = EnvConfig(
    appName: "Production",
    baseUrl: AppSecrets.supaBaseUrl,
    themeMode: themeMode == 'dark' ? ThemeMode.dark : ThemeMode.light,
    locale: local == 'bn' ? const Locale('bn') : const Locale('en'),
  );

  BuildConfig.instantiate(
    envType: Environment.production,
    envConfig: prodConfig,
  );
  Bloc.observer = GlobalBlocObserver();
  await di.init();

  runApp(const Application());
}
