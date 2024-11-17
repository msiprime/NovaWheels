import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/features/store/domain/repositories/store_repo.dart';

class FetchPublicStoreUseCase {
  final StoreRepo _storeRepository;

  FetchPublicStoreUseCase({
    required StoreRepo storeRepository,
  }) : _storeRepository = storeRepository;

  Future<Either<Failure, List<StoreEntity>>> call() async {
    return await _storeRepository.fetchPublicStores();
  }
}
