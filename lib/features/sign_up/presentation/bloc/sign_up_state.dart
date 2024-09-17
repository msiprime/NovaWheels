part of 'sign_up_bloc.dart';

enum SignUpStatus { initial, success, failure, loading, verifyOTP }

class SignUpState extends Equatable {
  final SignUpStatus status;
  final String fullName;
  final String email;
  final String password;
  final String phoneNumber;
  final String birthdate;
  final String errorMessage;
  final String responseMessage;
  final bool isAgeValidate;
  final String otp;

  const SignUpState(
      {this.status = SignUpStatus.initial,
      this.fullName = '',
      this.email = '',
      this.password = '',
      this.birthdate = '',
      this.phoneNumber = '',
      this.errorMessage = '',
      this.responseMessage = '',
      this.isAgeValidate = true,
      this.otp = ''});

  const SignUpState.initial()
      : status = SignUpStatus.initial,
        fullName = '',
        email = '',
        password = '',
        phoneNumber = '',
        birthdate = '',
        errorMessage = '',
        responseMessage = '',
        isAgeValidate = true,
        otp = '';

  SignUpState copyWith(
      {SignUpStatus? status,
      String? fullName,
      String? email,
      String? password,
      String? phoneNumber,
      String? birthdate,
      bool? isAgeValidate = true,
      String? errorMessage,
      String? responseMessage,
      String? otp}) {
    return SignUpState(
        status: status ?? this.status,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        password: password ?? this.password,
        birthdate: birthdate ?? this.birthdate,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        isAgeValidate: isAgeValidate ?? this.isAgeValidate,
        errorMessage: errorMessage ?? this.errorMessage,
        responseMessage: responseMessage ?? this.responseMessage,
        otp: otp ?? this.otp);
  }

  @override
  List<Object?> get props => [
        status,
        fullName,
        email,
        password,
        birthdate,
        phoneNumber,
        errorMessage,
        responseMessage,
        otp
      ];
}
