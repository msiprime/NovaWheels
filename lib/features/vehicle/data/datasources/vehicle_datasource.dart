abstract interface class VehicleDataSource {
  Future<List<Map<String, dynamic>>> fetchAllVehicles();

  Future<Map<String, dynamic>> fetchVehicleById({required String id});

  Future<List<Map<String, dynamic>>> fetchAllVehiclesByStore({
    required String storeId,
  });

  Stream<List<Map<String, dynamic>>> streamAllVehiclesByStore({
    required String storeId,
  });

  Future<Map<String, dynamic>> insertVehicle(Map<String, dynamic> vehicle);
}
