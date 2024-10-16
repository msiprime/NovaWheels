import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/sign_up/domain/repositories/sign_up_repositories.dart';

class ResendOTPUseCase {
  final SignUpRepository signupRepo;

  ResendOTPUseCase({
    required this.signupRepo,
  });

  Future<Either<Failure, String>> call({
    required String email,
  }) async {
    return await signupRepo.resendOTP(email: email);
  }
}
