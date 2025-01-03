import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_reponse_entity.dart';
import 'package:nova_wheels/features/vehicle/domain/repositories/vehicle_repo.dart';

class VehicleUseCase {
  final VehicleRepo vehicleRepo;

  VehicleUseCase({required this.vehicleRepo});

  Future<Either<Failure, List<VehicleResponseEntity>>> call() async {
    return await vehicleRepo.fetchAllVehicles();
  }
}
