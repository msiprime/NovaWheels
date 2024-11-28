import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/sign_up/domain/repositories/sign_up_repositories.dart';
import 'package:nova_wheels/features/sign_up/domain/use_cases/resend_otp_usecase.dart';

class MockSignUpRepository extends Mock implements SignUpRepository {}

void main() {
  late ResendOTPUseCase resendOTPUseCase;
  late MockSignUpRepository mockSignUpRepository;

  setUp(() {
    mockSignUpRepository = MockSignUpRepository();
    resendOTPUseCase = ResendOTPUseCase(signupRepo: mockSignUpRepository);
  });

  group('ResendOTPUseCase', () {
    const mockEmail = 'test@example.com';

    test(
        'should return Right("OTP Resent Successfully") when repository call succeeds',
        () async {
      // Arrange
      when(() => mockSignUpRepository.resendOTP(email: any(named: 'email')))
          .thenAnswer((_) async => const Right('OTP Resent Successfully'));

      // Act
      final result = await resendOTPUseCase.call(email: mockEmail);

      // Assert
      expect(result, const Right('OTP Resent Successfully'));
      verify(() => mockSignUpRepository.resendOTP(email: mockEmail)).called(1);
      verifyNoMoreInteractions(mockSignUpRepository);
    });

    test('should return Left(Failure) when repository call fails', () async {
      // Arrange
      final mockFailure = ServerFailure('Failed to resend OTP');
      when(() => mockSignUpRepository.resendOTP(email: any(named: 'email')))
          .thenAnswer((_) async => Left(mockFailure));

      // Act
      final result = await resendOTPUseCase.call(email: mockEmail);

      // Assert
      expect(result, Left(mockFailure));
      verify(() => mockSignUpRepository.resendOTP(email: mockEmail)).called(1);
      verifyNoMoreInteractions(mockSignUpRepository);
    });
  });
}
