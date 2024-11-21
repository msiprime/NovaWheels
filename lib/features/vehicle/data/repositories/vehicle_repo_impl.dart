import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/vehicle/data/datasources/vehicle_datasource.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_post_input.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_reponse_entity.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/vehicle_entity.dart';
import 'package:nova_wheels/features/vehicle/domain/repositories/vehicle_repo.dart';
import 'package:shared/shared.dart';

class VehicleRepoImpl implements VehicleRepo {
  final VehicleDataSource vehicleDataSource;

  VehicleRepoImpl({required this.vehicleDataSource});

  @override
  Future<Either<Failure, List<VehicleEntity>>> fetchAllVehicles() async {
    try {
      final response = await vehicleDataSource.fetchAllVehicles();

      final vehicles = response.map((vehicle) => vehicle.toEntity()).toList();

      return Right(vehicles);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<VehicleEntity>>> fetchAllVehiclesByStore(
      {required String storeId}) async {
    try {
      final response = await vehicleDataSource.fetchAllVehicles();

      final vehicles = response.map((vehicle) => vehicle.toEntity()).toList();

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
}
