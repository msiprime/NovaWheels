import 'package:nova_wheels/features/vehicle/data/models/vehicle_model.dart';

abstract interface class VehicleDataSource {
  Future<List<VehicleModel>> fetchAllVehicles();

  Future<List<VehicleModel>> fetchAllVehiclesByStore({
    required String storeId,
  });

  Future<Map<String, dynamic>> insertVehicle(Map<String, dynamic> vehicle);
}
