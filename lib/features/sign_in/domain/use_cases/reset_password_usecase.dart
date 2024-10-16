import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/sign_in/domain/repositories/sign_in_repositories.dart';

class ResetPasswordUseCase {
  final SignInRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<Either<Failure, String>> call(String password) async {
    return await repository.resetPassword(password: password);
  }
}
