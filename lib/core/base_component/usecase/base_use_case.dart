import 'package:nova_wheels/shared/utils/typedef.dart';

abstract interface class BaseUseCase<Failure, SuccessType, Params> {
  FutureFailureOr<SuccessType> call(Params params);
}

/// Reference => typedef.dart Future<Either<Failure, SuccessType>> call(Params params);

class NoParams {}

class NoResultType {}
