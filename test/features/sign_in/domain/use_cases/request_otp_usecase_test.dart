import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/sign_in/domain/repositories/sign_in_repositories.dart';
import 'package:nova_wheels/features/sign_in/domain/use_cases/request_otp_usecase.dart';

// Mock class for the repository
class MockSignInRepository extends Mock implements SignInRepository {}

void main() {
  late RequestOtpUseCase usecase;
  late MockSignInRepository mockRepository;

  setUp(() {
    mockRepository = MockSignInRepository();
    usecase = RequestOtpUseCase(mockRepository);
  });

  group('RequestOtpUseCase', () {
    const email = 'test@example.com';
    const tFailure = ServerFailure('Request OTP failed');

    test('should return success when OTP is requested successfully', () async {
      // Arrange
      when(() => mockRepository
              .requestOtpForForgetPassword(requestBody: {'email': email}))
          .thenAnswer((_) async => const Right(email));

      // Act
      final result = await usecase(email);

      // Assert
      expect(result, const Right(email));
      verify(() => mockRepository.requestOtpForForgetPassword(
          requestBody: {'email': email})).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when OTP request fails', () async {
      // Arrange
      when(() => mockRepository
              .requestOtpForForgetPassword(requestBody: {'email': email}))
          .thenAnswer((_) async => const Left(tFailure));

      // Act
      final result = await usecase(email);

      // Assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.requestOtpForForgetPassword(
          requestBody: {'email': email})).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
