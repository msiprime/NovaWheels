import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/core/base_component/usecase/base_use_case.dart';
import 'package:nova_wheels/features/sign_in/domain/repositories/sign_in_repositories.dart';
import 'package:nova_wheels/features/sign_in/domain/use_cases/user_signout_usecase.dart';

class MockSignInRepository extends Mock implements SignInRepository {}

void main() {
  late SignOutUseCase usecase;
  late MockSignInRepository mockRepository;

  setUp(() {
    mockRepository = MockSignInRepository();
    usecase = SignOutUseCase(signInRepository: mockRepository);
  });

  group('SignOutUseCase', () {
    test('should call signOut and return success', () async {
      // Arrange
      when(() => mockRepository.signOut())
          .thenAnswer((_) async => Right('Sign out successful'));

      // Act
      final result = await usecase(NoParams());

      // Assert
      expect(result, const Right('Sign out successful'));
      verify(() => mockRepository.signOut()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when signOut fails', () async {
      // Arrange
      const tFailure = ServerFailure('Sign out failed');
      when(() => mockRepository.signOut())
          .thenAnswer((_) async => const Left(tFailure));

      // Act
      final result = await usecase(NoParams());

      // Assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.signOut()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
