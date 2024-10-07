import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/vehicle/data/datasources/vehicle_datasource.dart';
import 'package:nova_wheels/features/vehicle/data/models/vehicle_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VehicleDataSourceImpl implements VehicleDataSource {
  final SupabaseClient supabaseClient;

  VehicleDataSourceImpl({
    required this.supabaseClient,
  });

  @override
  Future<List<VehicleModel>> fetchAllVehicles() async {
    try {
      final response = await supabaseClient.from('vehicles').select();

      final vehicles = response.map((e) => VehicleModel.fromJson(e)).toList();

      return vehicles;
    } on PostgrestException catch (e) {
      throw Failure(e.message);
    } on Exception catch (e) {
      throw Failure(e.toString());
    }
  }
}
