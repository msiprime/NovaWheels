import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/sign_in/domain/repositories/sign_in_repositories.dart';
import 'package:nova_wheels/features/sign_in/domain/use_cases/sign_in_use_case.dart';

// Mock class for the repository
class MockSignInRepository extends Mock implements SignInRepository {}

void main() {
  late SignInUseCase usecase;
  late MockSignInRepository mockRepository;

  setUp(() {
    mockRepository = MockSignInRepository();
    usecase = SignInUseCase(signInRepository: mockRepository);
  });

  group('SignInUseCase', () {
    final Map<String, dynamic> requestBody = {
      'email': 'test@example.com',
      'password': 'password123'
    };

    const tSuccessMessage = 'Sign in successful';
    const tFailure = ServerFailure('Sign in failed');

    test('should return success when sign in is successful', () async {
      // Arrange
      when(() => mockRepository.signIn(requestBody: requestBody))
          .thenAnswer((_) async => const Right(tSuccessMessage));

      // Act
      final result = await usecase(requestBody: requestBody);

      // Assert
      expect(result, const Right(tSuccessMessage));
      verify(() => mockRepository.signIn(requestBody: requestBody)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when sign in fails', () async {
      // Arrange
      when(() => mockRepository.signIn(requestBody: requestBody))
          .thenAnswer((_) async => const Left(tFailure));

      // Act
      final result = await usecase(requestBody: requestBody);

      // Assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.signIn(requestBody: requestBody)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
