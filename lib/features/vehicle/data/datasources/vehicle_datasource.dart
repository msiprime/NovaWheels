import 'package:nova_wheels/features/vehicle/data/models/vehicle_model.dart';

abstract interface class VehicleDataSource {
  Future<List<VehicleModel>> fetchAllVehicles();
}
