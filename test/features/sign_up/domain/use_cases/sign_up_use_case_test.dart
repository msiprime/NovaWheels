import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/sign_up/domain/repositories/sign_up_repositories.dart';
import 'package:nova_wheels/features/sign_up/domain/use_cases/sign_up_use_case.dart';

class MockSignUpRepository extends Mock implements SignUpRepository {}

void main() {
  late SignUpUseCase signUpUseCase;
  late MockSignUpRepository mockSignUpRepository;

  setUp(() {
    mockSignUpRepository = MockSignUpRepository();
    signUpUseCase = SignUpUseCase(signUpRepository: mockSignUpRepository);
  });

  group('SignUpUseCase', () {
    const mockRequestBody = {
      'email': 'test@example.com',
      'password': 'password123',
    };

    test(
        'should return Right("SignUp Successful") when repository call succeeds',
        () async {
      // Arrange
      when(() => mockSignUpRepository.signUp(
              requestBody: any(named: 'requestBody')))
          .thenAnswer((_) async => const Right('SignUp Successful'));

      // Act
      final result = await signUpUseCase.call(requestBody: mockRequestBody);

      // Assert
      expect(result, const Right('SignUp Successful'));
      verify(() => mockSignUpRepository.signUp(requestBody: mockRequestBody))
          .called(1);
      verifyNoMoreInteractions(mockSignUpRepository);
    });

    test('should return Left(Failure) when repository call fails', () async {
      // Arrange
      final mockFailure = ServerFailure('SignUp Failed');
      when(() => mockSignUpRepository.signUp(
              requestBody: any(named: 'requestBody')))
          .thenAnswer((_) async => Left(mockFailure));

      // Act
      final result = await signUpUseCase.call(requestBody: mockRequestBody);

      // Assert
      expect(result, Left(mockFailure));
      verify(() => mockSignUpRepository.signUp(requestBody: mockRequestBody))
          .called(1);
      verifyNoMoreInteractions(mockSignUpRepository);
    });
  });
}
