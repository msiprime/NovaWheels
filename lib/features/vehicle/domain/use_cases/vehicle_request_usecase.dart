import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_buy_rent_request_entity.dart';
import 'package:nova_wheels/features/vehicle/domain/repositories/vehicle_repo.dart';

class VehicleRequestUsecase {
  final VehicleRepo vehicleRepo;

  VehicleRequestUsecase({
    required this.vehicleRepo,
  });

  Future<Either<Failure, VehicleBuyRentRequestEntity>> call({
    required VehicleBuyRentRequestEntity vehicleRequest,
  }) async {
    return await vehicleRepo.buyOrRentVehicle(vehicleRequest);
  }
}
