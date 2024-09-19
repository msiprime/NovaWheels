import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/sign_in/domain/repositories/sign_in_repositories.dart';

class RequestOtpUseCase {
  final SignInRepository _repository;

  RequestOtpUseCase(this._repository);

  Future<Either<Failure, void>> call(String email) async {
    return await _repository.requestOtpForForgetPassword(requestBody: {
      'email': email,
    });
  }
}
