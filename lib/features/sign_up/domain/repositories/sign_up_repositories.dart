import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';

abstract interface class SignUpRepository {
  Future<Either<Failure, String>> signUp({
    required Map<String, dynamic> requestBody,
  });

  Future<Either<Failure, String>> verifyOTP({
    required Map<String, dynamic> requestBody,
  });

  Future<Either<Failure, String>> resendOTP({
    required String email,
  });
}
