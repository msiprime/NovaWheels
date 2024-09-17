part of 'injection_container.dart';

Future<void> _initDataSources() async {
  sl.registerLazySingleton<SignInDataSource>(
    () => SignInDataSourceImp(
      supabaseClient: sl.call(),
    ),
  );

  sl.registerLazySingleton<SignUpDataSource>(
    () => SignUpDataSourceImp(
      supabaseClient: sl.call(),
    ),
  );
}
