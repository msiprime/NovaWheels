import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/vehicle_entity.dart';
import 'package:nova_wheels/features/vehicle/domain/repositories/vehicle_repo.dart';

class VehicleByStoreUsecase {
  final VehicleRepo vehicleRepo;

  VehicleByStoreUsecase({required this.vehicleRepo});

  Future<Either<Failure, List<VehicleEntity>>> call({
    required String storeId,
  }) async {
    return await vehicleRepo.fetchAllVehiclesByStore(storeId: storeId);
  }
}
