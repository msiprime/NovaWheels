part of 'injection_container.dart';

Future<void> _initBlocs() async {
  sl.registerFactory(() => BaseBloc(BaseState.initial()));
  sl.registerFactory(
    () => LandingBloc(const LandingState(landingStatus: LandingStatus.initial)),
  );
  sl.registerFactory(
    () =>
        SignUpBloc(signUpUseCase: sl.call(), otpVerificationUseCase: sl.call()),
  );
  sl.registerFactory(
    () => SignInBloc(
        signInUseCase: sl.call(),
        signOutUseCase: sl.call(),
        googleSignInUseCase: sl.call(),
        resetPasswordUseCase: sl.call(),
        requestOtpUseCase: sl.call(),
        passResetOTPVerificationUseCase: sl.call()),
  );
}
