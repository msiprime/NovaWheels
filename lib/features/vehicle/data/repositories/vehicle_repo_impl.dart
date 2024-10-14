import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/vehicle/data/datasources/vehicle_datasource.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/vehicle_entity.dart';
import 'package:nova_wheels/features/vehicle/domain/repositories/vehicle_repo.dart';

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
}
