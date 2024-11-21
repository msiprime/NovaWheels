import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_post_input.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_reponse_entity.dart';
import 'package:nova_wheels/features/vehicle/domain/repositories/vehicle_repo.dart';

class PostVehicleUseCase {
  final VehicleRepo _vehicleRepository;

  PostVehicleUseCase(this._vehicleRepository);

  Future<Either<Failure, VehicleResponseEntity>> call(
      VehicleRequestEntity vehicle) async {
    return await _vehicleRepository.postVehicle(vehicle);
  }
}
