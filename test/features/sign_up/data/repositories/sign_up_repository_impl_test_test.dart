import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nova_wheels/features/sign_up/data/data_sources/sign_up_data_source.dart';
import 'package:nova_wheels/features/sign_up/data/repositories/sign_up_repository_impl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockSignUpDataSource extends Mock implements SignUpDataSource {}

void main() {
  late SignUpRepositoryImp repository;
  late MockSignUpDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockSignUpDataSource();
    repository = SignUpRepositoryImp(signUpDataSource: mockDataSource);
  });

  group('SignUpRepositoryImp', () {
    group('signUp', () {
      final mockRequestBody = {
        'email': 'test@example.com',
        'password': 'password123'
      };

      test('returns Left(Failure) when signUp fails', () async {
        when(() => mockDataSource.signUp(requestBody: mockRequestBody))
            .thenThrow(Exception('SignUp failed'));

        final result = await repository.signUp(requestBody: mockRequestBody);

        expect(result.isLeft(), true);
        result.fold(
          (failure) => expect(failure.message, 'Exception: SignUp failed'),
          (_) => null,
        );

        verify(() => mockDataSource.signUp(requestBody: mockRequestBody))
            .called(1);
      });
    });

    group('verifyOTP', () {
      final mockRequestBody = {'email': 'test@example.com', 'otp': '123456'};
      final mockAuthResponse = AuthResponse(
        session: Session(
          accessToken: 'mockAccessToken',
          refreshToken: 'mockRefreshToken',
          tokenType: 'mockTokenType',
          user: User(
              id: 'userId',
              appMetadata: {},
              userMetadata: {},
              aud: '',
              createdAt: ''),
        ),
      );

      test('returns Right(accessToken) when OTP verification is successful',
          () async {
        when(() => mockDataSource.verifyOTP(requestBody: mockRequestBody))
            .thenAnswer((_) async => mockAuthResponse);

        final result = await repository.verifyOTP(requestBody: mockRequestBody);

        expect(result.isRight(), true);
        result.fold(
          (_) => null,
          (accessToken) {
            expect(accessToken, mockAuthResponse.session?.accessToken);
          },
        );

        verify(() => mockDataSource.verifyOTP(requestBody: mockRequestBody))
            .called(1);
      });

      test('returns Left(Failure) when OTP verification fails', () async {
        when(() => mockDataSource.verifyOTP(requestBody: mockRequestBody))
            .thenThrow(Exception('OTP verification failed'));

        final result = await repository.verifyOTP(requestBody: mockRequestBody);

        expect(result.isLeft(), true);
        result.fold(
          (failure) =>
              expect(failure.message, 'Exception: OTP verification failed'),
          (_) => null,
        );

        verify(() => mockDataSource.verifyOTP(requestBody: mockRequestBody))
            .called(1);
      });
    });

    group('resendOTP', () {
      const email = 'test@example.com';
      final mockResendResponse = ResendResponse(messageId: 'mockMessageId');

      test('returns Right(messageId) when resendOTP is successful', () async {
        when(() => mockDataSource.resendOTP(email: email))
            .thenAnswer((_) async => mockResendResponse);

        final result = await repository.resendOTP(email: email);

        expect(result.isRight(), true);
        result.fold(
          (_) => null,
          (message) {
            expect(message, 'OTP has sent, id: mockMessageId');
          },
        );

        verify(() => mockDataSource.resendOTP(email: email)).called(1);
      });

      test('returns Left(Failure) when resendOTP fails', () async {
        when(() => mockDataSource.resendOTP(email: email))
            .thenThrow(Exception('Resend OTP failed'));

        final result = await repository.resendOTP(email: email);

        expect(result.isLeft(), true);
        result.fold(
          (failure) => expect(failure.message, 'Exception: Resend OTP failed'),
          (_) => null,
        );

        verify(() => mockDataSource.resendOTP(email: email)).called(1);
      });
    });
  });
}
