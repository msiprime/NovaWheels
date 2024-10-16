part of 'injection_container.dart';

Future<void> _initUseCases() async {
  sl.registerLazySingleton(
    () => SignInUseCase(
      signInRepository: sl.call(),
    ),
  );
  sl.registerLazySingleton(
    () => GoogleSignInUseCase(
      signInRepository: sl.call(),
    ),
  );
  sl.registerLazySingleton(
    () => SignOutUseCase(
      signInRepository: sl.call(),
    ),
  );

  sl.registerLazySingleton(
    () => SignUpUseCase(
      signUpRepository: sl.call(),
    ),
  );
  sl.registerLazySingleton(
    () => OTPVerificationUseCase(
      signUpRepository: sl.call(),
    ),
  );
  sl.registerLazySingleton(
    () => RequestOtpUseCase(
      sl.call(),
    ),
  );

  sl.registerLazySingleton(
    () => ResetPasswordUseCase(
      sl.call(),
    ),
  );
  sl.registerLazySingleton(
    () => PassResetOTPVerificationUseCase(
      repository: sl.call(),
    ),
  );

  /// vehicle usecase
  sl.registerLazySingleton(
    () => VehicleUseCase(
      vehicleRepo: sl.call(),
    ),
  );

  /// Store usecase
  // create store usecase
  sl.registerLazySingleton(
    () => CreateStoreUseCase(
      sl.call(),
    ),
  );
  // fetch store usecase
  sl.registerLazySingleton(
    () => FetchUserStoreUseCase(
      sl.call(),
    ),
  );
}
