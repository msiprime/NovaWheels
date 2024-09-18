import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/sign_in/domain/entities/sign_in_entity.dart';

abstract interface class SignInRepository {
  Future<Either<Failure, String>> signIn({
    required Map<String, dynamic> requestBody,
  });

  Future<Either<Failure, String>> signOut();

  Future<Either<Failure, User>> currentUser();

  Future<Either<Failure, String>> googleSignIn();
}
