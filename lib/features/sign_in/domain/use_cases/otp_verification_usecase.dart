import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/sign_in/domain/repositories/sign_in_repositories.dart';

class PassResetOTPVerificationUseCase {
  const PassResetOTPVerificationUseCase({required this.repository});

  final SignInRepository repository;

  Future<Either<Failure, String>> call({
    required Map<String, dynamic> requestBody,
  }) async {
    return await repository.verifyOTP(
      requestBody: requestBody,
    );
  }
}
