import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/core/base_component/usecase/base_use_case.dart';
import 'package:nova_wheels/features/sign_in/domain/entities/sign_in_entity.dart';
import 'package:nova_wheels/features/sign_in/domain/repositories/sign_in_repositories.dart';
import 'package:nova_wheels/shared/utils/typedef.dart';

class CurrentUserUsecase implements BaseUseCase<Failure, User, NoParams> {
  final SignInRepository repository;

  CurrentUserUsecase({
    required this.repository,
  });

  @override
  FutureFailureOr<User> call(NoParams params) async {
    return await repository.currentUser();
  }
}
