part of 'sign_in_bloc.dart';

enum SignInStatus {
  initial,
  success,
  failure,
  loading,
  loggedOut,
  otpVerified,
  otpSent
}

class SignInState extends Equatable {
  final SignInStatus status;
  final String email;
  final String password;
  final String fcmToken;
  final String phoneNumber;
  final String errorMessage;
  final String otp;

  const SignInState({
    this.status = SignInStatus.initial,
    this.email = '',
    this.password = '',
    this.fcmToken = '',
    this.phoneNumber = '',
    this.errorMessage = '',
    this.otp = '',
  });

  const SignInState.initial()
      : status = SignInStatus.initial,
        email = '',
        password = '',
        fcmToken = '',
        phoneNumber = '',
        otp = '',
        errorMessage = '';

  SignInState copyWith({
    SignInStatus? status,
    String? email,
    String? password,
    String? fcmToken,
    String? phoneNumber,
    String? errorMessage,
    String? otp,
  }) {
    return SignInState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      fcmToken: fcmToken ?? this.fcmToken,
      otp: otp ?? this.otp,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        email,
        password,
        fcmToken,
        phoneNumber,
        otp,
        errorMessage,
      ];
}
