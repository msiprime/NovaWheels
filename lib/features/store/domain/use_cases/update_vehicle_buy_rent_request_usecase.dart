import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/store/domain/repositories/store_repo.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_buy_rent_request_entity.dart';

class UpdateVehicleBuyRentRequestUsecase {
  final StoreRepo _storeRepository;

  UpdateVehicleBuyRentRequestUsecase({
    required StoreRepo storeRepository,
  }) : _storeRepository = storeRepository;

  Future<Either<Failure, List<VehicleBuyRentRequestEntity>>> call({
    required String requestId,
    required String status,
  }) async {
    return await _storeRepository.updateRequestStatus(
      status: status,
      requestId: requestId,
    );
  }
}
