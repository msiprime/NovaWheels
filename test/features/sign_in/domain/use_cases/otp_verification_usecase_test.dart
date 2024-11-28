import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/sign_in/domain/repositories/sign_in_repositories.dart';
import 'package:nova_wheels/features/sign_in/domain/use_cases/otp_verification_usecase.dart';

// Mock class for the repository
class MockSignInRepository extends Mock implements SignInRepository {}

void main() {
  late PassResetOTPVerificationUseCase usecase;
  late MockSignInRepository mockRepository;

  setUp(() {
    mockRepository = MockSignInRepository();
    usecase = PassResetOTPVerificationUseCase(repository: mockRepository);
  });

  group('PassResetOTPVerificationUseCase', () {
    const requestBody = {'otp': '123456'};
    const tMessage = 'OTP verified successfully';
    const tFailure = ServerFailure('OTP verification failed');

    test('should return success message when OTP is verified successfully',
        () async {
      // Arrange
      when(() => mockRepository.verifyOTP(requestBody: requestBody))
          .thenAnswer((_) async => const Right(tMessage));

      // Act
      final result = await usecase(requestBody: requestBody);

      // Assert
      expect(result, const Right(tMessage));
      verify(() => mockRepository.verifyOTP(requestBody: requestBody))
          .called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure message when OTP verification fails', () async {
      // Arrange
      when(() => mockRepository.verifyOTP(requestBody: requestBody))
          .thenAnswer((_) async => const Left(tFailure));

      // Act
      final result = await usecase(requestBody: requestBody);

      // Assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.verifyOTP(requestBody: requestBody))
          .called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
