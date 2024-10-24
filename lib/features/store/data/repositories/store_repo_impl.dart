import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/store/data/data_sources/store_datasource.dart';
import 'package:nova_wheels/features/store/data/models/store_model.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/features/store/domain/params/store_creation_params.dart';
import 'package:nova_wheels/features/store/domain/repositories/store_repo.dart';

class StoreRepoImpl implements StoreRepo {
  final StoreDataSource storeDataSource;

  StoreRepoImpl({
    required this.storeDataSource,
  });

  @override
  Future<Either<Failure, StoreEntity>> createStore({
    required StoreCreationParams storeCreationParams,
  }) async {
    final response = await storeDataSource.createStore(
      storeCreationParams: storeCreationParams,
    );

    return response.fold(
      (failure) => Left(failure),
      (mapResponse) {
        final storeModel = StoreModel.fromJson(mapResponse);
        return Right(storeModel.toEntity());
      },
    );
  }

  @override
  Future<Either<Failure, List<StoreEntity>>> fetchUserStores() async {
    final response = await storeDataSource.fetchUserStores();

    return response.fold(
      (failure) => Left(failure),
      (listMapResponse) {
        final List<StoreEntity> listStoreModel = listMapResponse
            .map((map) => StoreModel.fromJson(map).toEntity())
            .toList();
        return Right(listStoreModel);
      },
    );
  }

  @override
  Future<Either<Failure, List<StoreEntity>>> fetchAllStores() async {
    final response = await storeDataSource.fetchAllStores();

    return response.fold(
      (failure) => Left(failure),
      (listMapResponse) {
        final List<StoreEntity> listStoreModel = listMapResponse
            .map((map) => StoreModel.fromJson(map).toEntity())
            .toList();
        return Right(listStoreModel);
      },
    );
  }

  @override
  Future<Either<Failure, List<StoreEntity>>> deleteStoreById({
    required String storeId,
  }) async {
    final response = await storeDataSource.deleteStoreById(storeId: storeId);

    return response.fold(
      (failure) => Left(failure),
      (listMapResponse) {
        final List<StoreEntity> listStoreModel = listMapResponse
            .map((map) => StoreModel.fromJson(map).toEntity())
            .toList();
        return Right(listStoreModel);
      },
    );
  }
}
