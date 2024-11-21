import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_post_input.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_reponse_entity.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/vehicle_entity.dart';

abstract interface class VehicleRepo {
  Future<Either<Failure, List<VehicleEntity>>> fetchAllVehicles();

  Future<Either<Failure, List<VehicleEntity>>> fetchAllVehiclesByStore({
    required String storeId,
  });

  Future<Either<Failure, VehicleResponseEntity>> postVehicle(
      VehicleRequestEntity vehicle);

// Future<Either<Failure, VehicleEntity>> updateVehicle({
//   required Map<String, dynamic> vehicle,
// });
}
