import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/features/store/domain/repositories/store_repo.dart';

class FetchAllStoreUseCase {
  final StoreRepo _storeRepository;

  FetchAllStoreUseCase(this._storeRepository);

  Future<Either<Failure, List<StoreEntity>>> call() async {
    return await _storeRepository.fetchAllStores();
  }
}
