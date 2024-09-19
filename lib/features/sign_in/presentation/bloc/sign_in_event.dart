part of 'sign_in_bloc.dart';

class SignInEvent {
  const SignInEvent();
}

class EmailChangeEvent extends SignInEvent {
  const EmailChangeEvent({
    required this.email,
  });

  final String email;
}

class OtpChangeEvent extends SignInEvent {
  const OtpChangeEvent({
    required this.otp,
  });

  final String otp;
}

class PasswordChangeEvent extends SignInEvent {
  const PasswordChangeEvent({
    required this.password,
  });

  final String password;
}

class NewPasswordChangeEvent extends SignInEvent {
  const NewPasswordChangeEvent({
    required this.newPassword,
  });

  final String newPassword;
}

class PhoneNumberChangeEvent extends SignInEvent {
  const PhoneNumberChangeEvent({
    required this.phoneNumber,
  });

  final String phoneNumber;
}

class SignInSubmitted extends SignInEvent {}

class GoogleSignInSubmitted extends SignInEvent {
  const GoogleSignInSubmitted();
}

class SignOutSubmitted extends SignInEvent {
  const SignOutSubmitted();
}

class RequestOtpSubmitted extends SignInEvent {
  final String email;

  const RequestOtpSubmitted({required this.email});
}

class VerifyOtpSubmitted extends SignInEvent {
  final String otp;

  const VerifyOtpSubmitted({required this.otp});
}

class ResetPasswordSubmitted extends SignInEvent {
  final String password;

  const ResetPasswordSubmitted({required this.password});
}
