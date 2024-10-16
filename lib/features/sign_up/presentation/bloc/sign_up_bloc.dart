import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/features/sign_up/domain/use_cases/otp_verification_usecase.dart';
import 'package:nova_wheels/features/sign_up/domain/use_cases/resend_otp_usecase.dart';
import 'package:nova_wheels/features/sign_up/domain/use_cases/sign_up_use_case.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    required this.signUpUseCase,
    required this.otpVerificationUseCase,
    required this.resendOTPUseCase,
  }) : super(const SignUpState()) {
    on<SignUpSubmitted>(_onSignUpSubmitted);
    on<FirstNameChangeEvent>(_onFirstNameChangeEvent);
    on<EmailChangeEvent>(_onEmailChangeEvent);
    on<PasswordChangeEvent>(_onPasswordChangeEvent);
    on<BirthDateChangeEvent>(_onBirthDateChangeEvent);
    on<PhoneNumberChangeEvent>(_onPhoneNumberChangeEvent);
    on<SignUpStatusChange>(_onSignUpStatusChange);
    on<SignUpValidateAgeEvent>(_onValidateAgeEvent);
    on<OTPChangeEvent>(_onOTPChangeEvent);
    on<VerifyOTPEvent>(_onVerifyOTPEvent);
    on<ResendOTPSubmitted>(_onResendOTPSubmitted);
  }

  final SignUpUseCase signUpUseCase;
  final OTPVerificationUseCase otpVerificationUseCase;
  final ResendOTPUseCase resendOTPUseCase;

  FutureOr<void> _onFirstNameChangeEvent(
    FirstNameChangeEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(
      fullName: event.firstName,
      status: SignUpStatus.initial,
    ));
  }

  FutureOr<void> _onEmailChangeEvent(
    EmailChangeEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(
      email: event.email,
      status: SignUpStatus.initial,
    ));
  }

  FutureOr<void> _onPasswordChangeEvent(
    PasswordChangeEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(
      password: event.password,
      status: SignUpStatus.initial,
    ));
  }

  FutureOr<void> _onBirthDateChangeEvent(
    BirthDateChangeEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(
      birthdate: event.birthdate,
      status: SignUpStatus.initial,
    ));
  }

  FutureOr<void> _onPhoneNumberChangeEvent(
    PhoneNumberChangeEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(
      phoneNumber: event.phoneNumber,
      status: SignUpStatus.initial,
    ));
  }

  FutureOr<void> _onSignUpSubmitted(
    SignUpSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(status: SignUpStatus.loading));

    Map<String, dynamic> requestBody = {
      "full_name": state.fullName,
      "email": state.email,
      "password": state.password,
      "phone_number": "+88${state.phoneNumber}"
    };

    await Future.delayed(const Duration(seconds: 1));

    try {
      final response = await signUpUseCase.call(requestBody: requestBody);
      response.fold(
        (l) {
          debugPrint(l.toString());
          emit(
            state.copyWith(
              status: SignUpStatus.failure,
              errorMessage: l.message,
            ),
          );
        },
        (r) async {
          emit(
            state.copyWith(
              status: SignUpStatus.verifyOTP,
              responseMessage: r,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SignUpStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  FutureOr<void> _onValidateAgeEvent(
    SignUpValidateAgeEvent event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(
      isAgeValidate: event.isValidAge,
      status: SignUpStatus.initial,
    ));
  }

  FutureOr<void> _onSignUpStatusChange(
    SignUpStatusChange event,
    Emitter<SignUpState> emit,
  ) {
    emit(const SignUpState.initial());
  }

  FutureOr<void> _onOTPChangeEvent(
      OTPChangeEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(
      otp: event.otp,
      status: SignUpStatus.initial,
    ));
  }

  Future<FutureOr<void>> _onVerifyOTPEvent(
      VerifyOTPEvent event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(status: SignUpStatus.loading));
    Map<String, dynamic> requestBody = {
      "email": state.email,
      "otp": state.otp,
    };
    try {
      final response =
          await otpVerificationUseCase.call(requestBody: requestBody);
      response.fold(
        (l) {
          emit(
            state.copyWith(
              status: SignUpStatus.failure,
              errorMessage: l.message,
            ),
          );
        },
        (r) async {
          emit(
            state.copyWith(
              status: SignUpStatus.success,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SignUpStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  FutureOr<void> _onResendOTPSubmitted(
    ResendOTPSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    try {
      final response = await resendOTPUseCase.call(
        email: state.email,
      );
      response.fold(
        (l) {
          emit(
            state.copyWith(
              status: SignUpStatus.failure,
              errorMessage: l.message,
            ),
          );
        },
        (r) async {
          emit(
            state.copyWith(
              status: SignUpStatus.verifyOTP,
              responseMessage: r,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SignUpStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
