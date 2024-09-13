import 'package:dartz/dartz.dart';
import 'package:nova_wheels/features/sign_up/domain/entities/sign_up_entity.dart';

abstract interface class SignUpRepository {
  Future<Either<String, SignUpEntity>> signUp({
    required Map<String, dynamic> requestBody,
  });

  Future<Either<String, SignUpEntity>> verifyOTP({
    required Map<String, dynamic> requestBody,
  });
}
