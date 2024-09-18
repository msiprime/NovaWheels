import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/core/base_component/usecase/base_use_case.dart';
import 'package:nova_wheels/features/sign_in/domain/repositories/sign_in_repositories.dart';
import 'package:nova_wheels/shared/utils/typedef.dart';

class SignOutUseCase implements BaseUseCase<Failure, void, NoParams> {
  final SignInRepository signInRepository;

  SignOutUseCase({
    required this.signInRepository,
  });

  @override
  FutureFailureOr<void> call(NoParams params) async {
    return await signInRepository.signOut();
  }
}
