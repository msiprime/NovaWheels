import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/sign_up/domain/repositories/sign_up_repositories.dart';
import 'package:nova_wheels/features/sign_up/domain/use_cases/otp_verification_usecase.dart';

class MockSignUpRepository extends Mock implements SignUpRepository {}

void main() {
  late OTPVerificationUseCase otpVerificationUseCase;
  late MockSignUpRepository mockSignUpRepository;

  setUp(() {
    mockSignUpRepository = MockSignUpRepository();
    otpVerificationUseCase = OTPVerificationUseCase(
      signUpRepository: mockSignUpRepository,
    );
  });

  group('OTPVerificationUseCase', () {
    const mockRequestBody = {
      'otp': '123456',
      'phone': '+8801234567890',
    };

    test(
        'should return Right("OTP Verified") when the repository call succeeds',
        () async {
      // Arrange
      when(() => mockSignUpRepository.verifyOTP(
              requestBody: any(named: 'requestBody')))
          .thenAnswer((_) async => const Right('OTP Verified'));

      // Act
      final result =
          await otpVerificationUseCase.call(requestBody: mockRequestBody);

      // Assert
      expect(result, const Right('OTP Verified'));
      verify(() => mockSignUpRepository.verifyOTP(requestBody: mockRequestBody))
          .called(1);
      verifyNoMoreInteractions(mockSignUpRepository);
    });

    test('should return Left(Failure) when the repository call fails',
        () async {
      // Arrange
      final mockFailure = ServerFailure('Invalid OTP');
      when(() => mockSignUpRepository.verifyOTP(
              requestBody: any(named: 'requestBody')))
          .thenAnswer((_) async => Left(mockFailure));

      // Act
      final result =
          await otpVerificationUseCase.call(requestBody: mockRequestBody);

      // Assert
      expect(result, Left(mockFailure));
      verify(() => mockSignUpRepository.verifyOTP(requestBody: mockRequestBody))
          .called(1);
      verifyNoMoreInteractions(mockSignUpRepository);
    });
  });
}
