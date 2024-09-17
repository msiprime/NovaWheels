import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/sign_in/domain/repositories/sign_in_repositories.dart';

class SignInUseCase {
  const SignInUseCase({required this.signInRepository});

  final SignInRepository signInRepository;

  Future<Either<Failure, String>> call({
    required Map<String, dynamic> requestBody,
  }) async {
    return await signInRepository.signIn(requestBody: requestBody);
  }
}
