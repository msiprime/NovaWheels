import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/sign_in/domain/repositories/sign_in_repositories.dart';
import 'package:nova_wheels/features/sign_in/domain/use_cases/reset_password_usecase.dart';

// Mock class for the repository
class MockSignInRepository extends Mock implements SignInRepository {}

void main() {
  late ResetPasswordUseCase usecase;
  late MockSignInRepository mockRepository;

  setUp(() {
    mockRepository = MockSignInRepository();
    usecase = ResetPasswordUseCase(mockRepository);
  });

  group('ResetPasswordUseCase', () {
    const password = 'newSecurePassword123';
    const tFailure = ServerFailure('Password reset failed');
    const tSuccessMessage = 'Password reset successful';

    test('should return success when password is reset successfully', () async {
      // Arrange
      when(() => mockRepository.resetPassword(password: password))
          .thenAnswer((_) async => const Right(tSuccessMessage));

      // Act
      final result = await usecase(password);

      // Assert
      expect(result, const Right(tSuccessMessage));
      verify(() => mockRepository.resetPassword(password: password)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when password reset fails', () async {
      // Arrange
      when(() => mockRepository.resetPassword(password: password))
          .thenAnswer((_) async => const Left(tFailure));

      // Act
      final result = await usecase(password);

      // Assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.resetPassword(password: password)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
