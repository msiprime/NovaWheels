import 'package:dartz/dartz.dart';
import 'package:nova_wheels/features/sign_in/domain/entities/sign_in_entity.dart';

abstract interface class SignInRepository {
  Future<Either<String, SignInEntity>> signIn({
    required Map<String, dynamic> requestBody,
  });
}
