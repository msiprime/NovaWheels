import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/store/data/data_sources/store_datasource.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/features/store/domain/repositories/store_repo.dart';

class CreateStoreUseCase {
  final StoreRepo _storeRepository;

  CreateStoreUseCase(this._storeRepository);

  Future<Either<Failure, StoreEntity>> call({
    required StoreCreationParams storeCreationParams,
  }) async {
    return await _storeRepository.createStore(
      storeCreationParams: storeCreationParams,
    );
  }
}
