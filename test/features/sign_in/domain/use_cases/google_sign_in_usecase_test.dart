import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/sign_in/domain/repositories/sign_in_repositories.dart';
import 'package:nova_wheels/features/sign_in/domain/use_cases/google_sign_in_usecase.dart';

// Mock class for the repository
class MockSignInRepository extends Mock implements SignInRepository {}

void main() {
  late GoogleSignInUseCase usecase;
  late MockSignInRepository mockRepository;

  setUp(() {
    mockRepository = MockSignInRepository();
    usecase = GoogleSignInUseCase(signInRepository: mockRepository);
  });

  group('GoogleSignInUseCase', () {
    const tUserId = '12345';

    test('should return user ID when Google Sign-In is successful', () async {
      // Arrange
      when(() => mockRepository.googleSignIn())
          .thenAnswer((_) async => const Right(tUserId));

      // Act
      final result = await usecase();

      // Assert
      expect(result, const Right(tUserId));
      verify(() => mockRepository.googleSignIn()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return Failure when Google Sign-In fails', () async {
      // Arrange
      var tFailure = ServerFailure('Google Sign-In Failed');
      when(() => mockRepository.googleSignIn())
          .thenAnswer((_) async => Left(tFailure));

      // Act
      final result = await usecase();

      // Assert
      expect(result, Left(tFailure));
      verify(() => mockRepository.googleSignIn()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
