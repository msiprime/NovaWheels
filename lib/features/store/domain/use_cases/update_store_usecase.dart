import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/features/store/domain/repositories/store_repo.dart';

class UpdateStoreUseCase {
  final StoreRepo _storeRepository;

  UpdateStoreUseCase({required StoreRepo storeRepository})
      : _storeRepository = storeRepository;

  Future<Either<Failure, StoreEntity>> call(StoreEntity store) async {
    return await _storeRepository.updateStore(store: store);
  }
}
