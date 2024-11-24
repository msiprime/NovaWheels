import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/vehicle/data/datasources/vehicle_datasource.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_post_input.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_reponse_entity.dart';
import 'package:nova_wheels/features/vehicle/domain/repositories/vehicle_repo.dart';
import 'package:shared/shared.dart';

class VehicleRepoImpl implements VehicleRepo {
  final VehicleDataSource vehicleDataSource;

  VehicleRepoImpl({required this.vehicleDataSource});

  @override
  Future<Either<Failure, List<VehicleResponseEntity>>>
      fetchAllVehicles() async {
    try {
      final response = await vehicleDataSource.fetchAllVehicles();

      final vehicles = response
          .map((vehicle) => VehicleResponseEntity.fromJson(vehicle))
          .toList();

      return Right(vehicles);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<VehicleResponseEntity>>> fetchAllVehiclesByStore(
      {required String storeId}) async {
    try {
      final response =
          await vehicleDataSource.fetchAllVehiclesByStore(storeId: storeId);
      final vehicles = response
          .map((vehicle) => VehicleResponseEntity.fromJson(vehicle))
          .toList();

      return Right(vehicles);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, VehicleResponseEntity>> postVehicle(
      VehicleRequestEntity vehicle) async {
    try {
      final vehicleJson = vehicle.toJson();
      final response = await vehicleDataSource.insertVehicle(vehicleJson);
      final vehicleEntity = VehicleResponseEntity.fromJson(response);
      return Right(vehicleEntity);
    } catch (e) {
      logE('exception in repo impl $e');
      return Left(Failure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<VehicleResponseEntity>>>
      streamAllVehiclesByStore({
    required String storeId,
  }) {
    try {
      // Get the stream from the data source
      final response =
          vehicleDataSource.streamAllVehiclesByStore(storeId: storeId);

      // Map the stream to emit Either<Failure, List<VehicleResponseEntity>>
      return response
          .map<Either<Failure, List<VehicleResponseEntity>>>((snapshot) {
        try {
          // Transform the raw data into VehicleResponseEntity list
          final vehicles = snapshot
              .map((vehicle) => VehicleResponseEntity.fromJson(vehicle))
              .toList();
          return Right(vehicles); // Wrap success in Right
        } catch (e) {
          // Catch transformation errors and emit Failure
          return Left(Failure(e.toString()));
        }
      }).handleError((error) {
        // Handle errors emitted by the data source's stream
        return Left(Failure(error.toString()));
      });
    } catch (e) {
      // If an error occurs while setting up the stream, emit it immediately
      return Stream.value(Left(Failure(e.toString())));
    }
  }
}
