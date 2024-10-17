import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/features/store/domain/repositories/store_repo.dart';

class DeleteStoreUseCase {
  final StoreRepo _storeRepository;

  DeleteStoreUseCase(this._storeRepository);

  Future<Either<Failure, List<StoreEntity>>> call({
    required String storeId,
  }) async {
    return await _storeRepository.deleteStoreById(storeId: storeId);
  }
}
