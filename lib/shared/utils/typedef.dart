import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';

/// Best Practice OverLoading
typedef FutureResult<T, Q> = Future<Either<T, Q>>;

/// Best Practice
typedef FutureFailureOr<T> = Future<Either<Failure, T>>;

typedef FutureFailureOrVoid = FutureFailureOr<void>;
