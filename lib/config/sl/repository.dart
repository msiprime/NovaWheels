part of 'injection_container.dart';

Future<void> _initRepositories() async {
  sl.registerLazySingleton<SignInRepository>(
    () => SignInRepoImp(
      connectionChecker: sl.call(),
      signInRemoteDataSource: sl.call(),
    ),
  );
  sl.registerLazySingleton<SignUpRepository>(
    () => SignUpRepositoryImp(
      signUpDataSource: sl.call(),
    ),
  );

  /// user profile repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImp(
      profileDataSource: sl.call(),
    ),
  );

  /// vehicle repository
  sl.registerLazySingleton<VehicleRepo>(
    () => VehicleRepoImpl(
      vehicleDataSource: sl.call(),
    ),
  );

  /// store repository
  sl.registerLazySingleton<StoreRepo>(
    () => StoreRepoImpl(
      storeDataSource: sl.call(),
    ),
  );
}
