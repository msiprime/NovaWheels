import 'package:dartz/dartz.dart';
import 'package:nova_wheels/features/sign_in/domain/entities/sign_in_entity.dart';
import 'package:nova_wheels/features/sign_in/domain/repositories/sign_in_repositories.dart';

class SignInUseCase {
  const SignInUseCase({required this.signInRepository});

  final SignInRepository signInRepository;

  Future<Either<String, SignInEntity>> call({
    required Map<String, dynamic> requestBody,
  }) async {
    return await signInRepository.signIn(requestBody: requestBody);
  }
}
