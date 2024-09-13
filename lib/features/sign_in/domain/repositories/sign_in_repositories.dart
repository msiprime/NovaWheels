import 'package:dartz/dartz.dart';
import 'package:quick_start/features/sign_in/domain/entities/sign_in_entity.dart';

abstract interface class SignInRepository {
  Future<Either<String, SignInEntity>> signIn({
    required Map<String, dynamic> requestBody,
  });
}
