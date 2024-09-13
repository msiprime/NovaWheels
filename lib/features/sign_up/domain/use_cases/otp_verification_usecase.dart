import 'package:dartz/dartz.dart';
import 'package:nova_wheels/features/sign_up/domain/entities/sign_up_entity.dart';
import 'package:nova_wheels/features/sign_up/domain/repositories/sign_up_repositories.dart';

class OTPVerificationUseCase {
  const OTPVerificationUseCase({required this.signUpRepository});

  final SignUpRepository signUpRepository;

  Future<Either<String, SignUpEntity>> call({
    required Map<String, dynamic> requestBody,
  }) async {
    return await signUpRepository.verifyOTP(
      requestBody: requestBody,
    );
  }
}
