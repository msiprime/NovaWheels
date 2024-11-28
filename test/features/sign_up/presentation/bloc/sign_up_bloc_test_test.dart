import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nova_wheels/features/sign_up/domain/use_cases/otp_verification_usecase.dart';
import 'package:nova_wheels/features/sign_up/domain/use_cases/resend_otp_usecase.dart';
import 'package:nova_wheels/features/sign_up/domain/use_cases/sign_up_use_case.dart';
import 'package:nova_wheels/features/sign_up/presentation/bloc/sign_up_bloc.dart';

class MockSignUpUseCase extends Mock implements SignUpUseCase {}

class MockOTPVerificationUseCase extends Mock
    implements OTPVerificationUseCase {}

class MockResendOTPUseCase extends Mock implements ResendOTPUseCase {}

void main() {
  late MockSignUpUseCase signUpUseCase;
  late MockOTPVerificationUseCase otpVerificationUseCase;
  late MockResendOTPUseCase resendOTPUseCase;

  setUp(() {
    // Arrange: Set up mocks and dependencies
    signUpUseCase = MockSignUpUseCase();
    otpVerificationUseCase = MockOTPVerificationUseCase();
    resendOTPUseCase = MockResendOTPUseCase();
  });

  group('SignUpBloc', () {
    test('initial state is SignUpState.initial()', () {
      // Arrange
      final bloc = SignUpBloc(
        signUpUseCase: signUpUseCase,
        otpVerificationUseCase: otpVerificationUseCase,
        resendOTPUseCase: resendOTPUseCase,
      );

      // Assert: Verify the initial state
      expect(bloc.state, const SignUpState());
    });

    blocTest<SignUpBloc, SignUpState>(
      'emits updated state when FirstNameChangeEvent is added',
      build: () {
        // Arrange: Initialize the bloc
        return SignUpBloc(
          signUpUseCase: signUpUseCase,
          otpVerificationUseCase: otpVerificationUseCase,
          resendOTPUseCase: resendOTPUseCase,
        );
      },
      // Act: Perform the event
      act: (bloc) => bloc.add(const FullNameChangeEvent(firstName: 'John')),
      // Assert: Verify the output states
      expect: () => [
        const SignUpState(fullName: 'John', status: SignUpStatus.initial),
      ],
    );

    blocTest<SignUpBloc, SignUpState>(
      'emits updated state when EmailChangeEvent is added',
      build: () {
        // Arrange: Initialize the bloc
        return SignUpBloc(
          signUpUseCase: signUpUseCase,
          otpVerificationUseCase: otpVerificationUseCase,
          resendOTPUseCase: resendOTPUseCase,
        );
      },
      // Act: Perform the event
      act: (bloc) => bloc.add(const EmailChangeEvent(email: 'John')),
      // Assert: Verify the output states
      expect: () => [
        const SignUpState(email: 'John', status: SignUpStatus.initial),
      ],
    );

    blocTest<SignUpBloc, SignUpState>(
      'emits updated state when PasswordChangeEvent is added',
      build: () {
        // Arrange: Initialize the bloc
        return SignUpBloc(
          signUpUseCase: signUpUseCase,
          otpVerificationUseCase: otpVerificationUseCase,
          resendOTPUseCase: resendOTPUseCase,
        );
      },
      // Act: Perform the event
      act: (bloc) => bloc.add(const PasswordChangeEvent(password: 'password')),
      // Assert: Verify the output states
      expect: () => [
        const SignUpState(password: 'password', status: SignUpStatus.initial),
      ],
    );

    blocTest<SignUpBloc, SignUpState>(
      'emits updated state when PhoneNumberChangeEvent is added',
      build: () {
        // Arrange: Initialize the bloc
        return SignUpBloc(
          signUpUseCase: signUpUseCase,
          otpVerificationUseCase: otpVerificationUseCase,
          resendOTPUseCase: resendOTPUseCase,
        );
      },
      // Act: Perform the event
      act: (bloc) =>
          bloc.add(const PhoneNumberChangeEvent(phoneNumber: '01797572236')),
      // Assert: Verify the output states
      expect: () => [
        const SignUpState(
            phoneNumber: '01797572236', status: SignUpStatus.initial),
      ],
    );
  });
}
