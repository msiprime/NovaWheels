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
    () => FetchVehicleBloc(
      streamOfStoreVehiclesUsecase: sl.call(),
      storeVehicleUsecase: sl.call(),
      vehicleUseCase: sl.call(),
    ),
  );

  sl.registerFactory(
    () => PostVehicleBloc(
      postVehicleUseCase: sl.call(),
    ),
  );

  /// Store bloc
  // fetch store
  // delete store
  sl.registerFactory(
    () => UpdateStoreBloc(
      updateStoreUseCase: sl.call(),
      deleteStoreUseCase: sl.call(),
    ),
  );

  /// Image Picker Cubit
  // sl.registerLazySingleton(
  //   () => ImagePickerBloc(
  //     imageType: ImageType.,
  //   ),
  // );

  /// profile
  sl.registerLazySingleton(
    () => ProfileBloc(
      profileDataUsecase: sl.call(),
      updateProfileDataUsecase: sl.call(),
    )..add(GetProfileDataEvent()),
  );
}
