import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/store/domain/params/store_creation_params.dart';

abstract interface class StoreDataSource {
  Future<Either<Failure, Map<String, dynamic>>> createStore({
    required StoreCreationParams storeCreationParams,
  });

  Future<Either<Failure, List<Map<String, dynamic>>>> fetchUserStores();

  Future<Either<Failure, List<Map<String, dynamic>>>> fetchAllStores();

  Future<Either<Failure, List<Map<String, dynamic>>>> deleteStoreById({
    required String storeId,
  });
}
