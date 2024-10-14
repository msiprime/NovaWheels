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

  /// vehicle data source
  sl.registerLazySingleton<VehicleDataSource>(
    () => VehicleDataSourceImpl(
      supabaseClient: sl.call(),
    ),
  );

  /// Store data source
  sl.registerLazySingleton<StoreDataSource>(
    () => StoreDataSourceImpl(
      supabaseClient: sl.call(),
    ),
  );
}
