import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/features/store/domain/params/store_creation_params.dart';

abstract interface class StoreRepo {
  Future<Either<Failure, StoreEntity>> createStore({
    required StoreCreationParams storeCreationParams,
  });

  Future<Either<Failure, List<StoreEntity>>> fetchUserStores();

  Future<Either<Failure, List<StoreEntity>>> fetchPublicStores();

  Future<Either<Failure, List<StoreEntity>>> deleteStoreById({
    required String storeId,
  });
}
