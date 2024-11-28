import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/core/base_component/usecase/base_use_case.dart';
import 'package:nova_wheels/features/sign_in/domain/entities/sign_in_entity.dart';
import 'package:nova_wheels/features/sign_in/domain/repositories/sign_in_repositories.dart';
import 'package:nova_wheels/features/sign_in/domain/use_cases/current_user_data_usecase.dart';

// Mock class for the repository
class MockSignInRepository extends Mock implements SignInRepository {}

void main() {
  late CurrentUserUsecase usecase;
  late MockSignInRepository mockRepository;

  setUp(() {
    mockRepository = MockSignInRepository();
    usecase = CurrentUserUsecase(repository: mockRepository);
  });

  group('CurrentUserUsecase', () {
    var tUser = User(id: '1', email: 'test@example.com', fullName: 'Test User');

    test('should return User when the repository returns a User', () async {
      // Arrange
      when(() => mockRepository.currentUser())
          .thenAnswer((_) async => Right(tUser));

      // Act
      final result = await usecase(NoParams());

      // Assert
      expect(result, Right(tUser));
      verify(() => mockRepository.currentUser()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return Failure when the repository returns a Failure',
        () async {
      // Arrange
      var tFailure = ServerFailure('Server error');
      when(() => mockRepository.currentUser())
          .thenAnswer((_) async => Left(tFailure));

      // Act
      final result = await usecase(NoParams());

      // Assert
      expect(result, Left(tFailure));
      verify(() => mockRepository.currentUser()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
