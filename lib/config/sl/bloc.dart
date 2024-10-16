part of 'injection_container.dart';

Future<void> _initBlocs() async {
  sl.registerLazySingleton(() => BaseBloc(BaseState.initial()));
  sl.registerLazySingleton(
    () => LandingBloc(const LandingState(landingStatus: LandingStatus.initial)),
  );
  sl.registerLazySingleton(
    () => SignUpBloc(
      signUpUseCase: sl.call(),
      otpVerificationUseCase: sl.call(),
      resendOTPUseCase: sl.call(),
    ),
  );
  sl.registerLazySingleton(
    () => SignInBloc(
      signInUseCase: sl.call(),
      signOutUseCase: sl.call(),
      googleSignInUseCase: sl.call(),
      resetPasswordUseCase: sl.call(),
      requestOtpUseCase: sl.call(),
      passResetOTPVerificationUseCase: sl.call(),
    ),
  );

  /// vehicle bloc

  sl.registerLazySingleton(
    () => VehicleBloc(
      vehicleUseCase: sl.call(),
    ),
  );

  /// Store bloc
  // fetch store
  sl.registerFactory(
    () => FetchStoreBloc(
      fetchUserStoreUseCase: sl.call(),
    ),
  );
  // /// Image Picker Cubit
  // sl.registerLazySingleton(
  //   () => ImagePickerBloc(),
  // );
}
