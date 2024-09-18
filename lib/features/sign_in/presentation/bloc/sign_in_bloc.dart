import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/core/base_component/usecase/base_use_case.dart';
import 'package:nova_wheels/features/sign_in/domain/use_cases/google_sign_in_usecase.dart';
import 'package:nova_wheels/features/sign_in/domain/use_cases/sign_in_use_case.dart';
import 'package:nova_wheels/features/sign_in/domain/use_cases/user_signout_usecase.dart';
import 'package:nova_wheels/shared/local_storage/cache_service.dart';
import 'package:nova_wheels/shared/utils/logger.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({
    required this.signInUseCase,
    required this.signOutUseCase,
    required this.googleSignInUseCase,
  }) : super(const SignInState()) {
    on<EmailChangeEvent>(_onEmailChangeEvent);
    on<PasswordChangeEvent>(_onPasswordChangeEvent);
    on<PhoneNumberChangeEvent>(_onPhoneNumberChangeEvent);
    on<SignInSubmitted>(_onSignInSubmittedEvent);
    on<SignOutSubmitted>(_onSignOutSubmittedEvent);
    on<GoogleSignInSubmitted>(_onGoogleSignInSubmittedEvent);
  }

  final SignInUseCase signInUseCase;
  final SignOutUseCase signOutUseCase;
  final GoogleSignInUseCase googleSignInUseCase;

  FutureOr<void> _onEmailChangeEvent(
    EmailChangeEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(
      email: event.email,
      status: SignInStatus.initial,
    ));
  }

  FutureOr<void> _onPasswordChangeEvent(
    PasswordChangeEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(
      password: event.password,
      status: SignInStatus.initial,
    ));
  }

  FutureOr<void> _onPhoneNumberChangeEvent(
    PhoneNumberChangeEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(
      phoneNumber: event.phoneNumber,
      status: SignInStatus.initial,
    ));
  }

  Future<void> _onSignInSubmittedEvent(
      SignInSubmitted event, Emitter<SignInState> emit) async {
    {
      emit(state.copyWith(status: SignInStatus.loading));

      await Future.delayed(const Duration(seconds: 1));

      try {
        String? fcmToken;
        try {
          fcmToken ??= await CacheService.instance.retrieveFcmToken();
        } catch (_) {
          Log.error('Failed to retrieve FCM token');
        }

        Map<String, dynamic> requestBody = {
          "email": state.email.trim(),
          "password": state.password,
        };

        final response = await signInUseCase.call(requestBody: requestBody);
        response.fold(
          (l) {
            emit(
              state.copyWith(
                status: SignInStatus.failure,
                errorMessage: l.message,
              ),
            );
          },
          (r) async {
            CacheService.instance.storeBearerToken((r));
            emit(
              state.copyWith(
                status: SignInStatus.success,
                fcmToken: r,
              ),
            );
          },
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: SignInStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    }
  }

  Future<FutureOr<void>> _onSignOutSubmittedEvent(
    SignOutSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(status: SignInStatus.loading));
    try {
      await Future.delayed(1.seconds);
      await signOutUseCase.call(NoParams());
      emit(state.copyWith(status: SignInStatus.loggedOut));
    } catch (e) {
      emit(
        state.copyWith(
          status: SignInStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
    // CacheService.instance.clearAll();
    emit(state.copyWith(status: SignInStatus.initial));
  }

  FutureOr<void> _onGoogleSignInSubmittedEvent(
      GoogleSignInSubmitted event, Emitter<SignInState> emit) async {
    {
      emit(state.copyWith(status: SignInStatus.loading));

      await Future.delayed(const Duration(seconds: 1));

      try {
        String? fcmToken;
        try {
          fcmToken ??= await CacheService.instance.retrieveFcmToken();
        } catch (_) {
          Log.error('Failed to retrieve FCM token');
        }
        final response = await googleSignInUseCase.call();
        response.fold(
          (l) {
            emit(
              state.copyWith(
                status: SignInStatus.failure,
                errorMessage: l.message,
              ),
            );
          },
          (r) async {
            CacheService.instance.storeBearerToken((r));
            emit(
              state.copyWith(
                status: SignInStatus.success,
                fcmToken: r,
              ),
            );
          },
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: SignInStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    }
  }
}
