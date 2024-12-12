import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_reponse_entity.dart';
import 'package:nova_wheels/features/vehicle/domain/repositories/vehicle_repo.dart';

class VehicleByIdUsecase {
  final VehicleRepo vehicleRepo;

  VehicleByIdUsecase({
    required this.vehicleRepo,
  });

  Future<Either<Failure, VehicleResponseEntity>> call({
    required String id,
  }) async {
    return await vehicleRepo.fetchVehicleById(id: id);
  }
}
