import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/exceptions.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/sign_up/data/data_sources/sign_up_data_source.dart';
import 'package:nova_wheels/features/sign_up/domain/repositories/sign_up_repositories.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../shared/utils/logger.dart';

class SignUpRepositoryImp implements SignUpRepository {
  const SignUpRepositoryImp({required this.signUpDataSource});

  final SignUpDataSource signUpDataSource;

  @override
  Future<Either<Failure, String>> signUp({
    required Map<String, dynamic> requestBody,
  }) async {
    try {
      final AuthResponse response =
          await signUpDataSource.signUp(requestBody: requestBody);
      Log.error(response.toString());

      final user = response.user;

      if (user == null) {
        throw const ServerException('User is not created');
      }

      final confirmationSentAt = user.confirmationSentAt;
      if (confirmationSentAt == null) {
        throw const ServerException('OTP is not sent');
      }

      return Right(confirmationSentAt);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> verifyOTP(
      {required Map<String, dynamic> requestBody}) async {
    try {
      final AuthResponse response =
          await signUpDataSource.verifyOTP(requestBody: requestBody);

      String? accessToken = response.session?.accessToken;
      if (accessToken == null) {
        return Left(Failure('User access token is null'));
      }
      Log.debug(accessToken);
      return Right(accessToken);
    } catch (e) {
      Log.debug(e.toString());
      return Left(Failure(e.toString()));
    }
  }
}
