import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_reponse_entity.dart';
import 'package:nova_wheels/features/vehicle/domain/repositories/vehicle_repo.dart';

class StreamOfStoreVehiclesUsecase {
  final VehicleRepo vehicleRepo;

  StreamOfStoreVehiclesUsecase({required this.vehicleRepo});

  Stream<Either<Failure, List<VehicleResponseEntity>>> call({
    required String storeId,
  }) {
    return vehicleRepo.streamAllVehiclesByStore(storeId: storeId);
  }
}
