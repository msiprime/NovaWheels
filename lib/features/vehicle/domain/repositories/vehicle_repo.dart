import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_buy_rent_request_entity.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_post_input.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_reponse_entity.dart';

abstract interface class VehicleRepo {
  Future<Either<Failure, List<VehicleResponseEntity>>> fetchAllVehicles();

  Future<Either<Failure, VehicleResponseEntity>> fetchVehicleById({
    required String id,
  });

  Future<Either<Failure, List<VehicleResponseEntity>>> fetchAllVehiclesByStore({
    required String storeId,
  });

  Future<Either<Failure, VehicleResponseEntity>> postVehicle(
      VehicleRequestEntity vehicle);

  Stream<Either<Failure, List<VehicleResponseEntity>>>
      streamAllVehiclesByStore({
    required String storeId,
  });

// Future<Either<Failure, VehicleEntity>> updateVehicle({
//   required Map<String, dynamic> vehicle,
// });

  // New method for buy or rent operation
  Future<Either<Failure, VehicleBuyRentRequestEntity>> buyOrRentVehicle(
      VehicleBuyRentRequestEntity vehicleRequest);
}
