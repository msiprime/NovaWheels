import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/vehicle/data/datasources/vehicle_datasource.dart';
import 'package:shared/shared.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VehicleDataSourceImpl implements VehicleDataSource {
  final SupabaseClient supabaseClient;

  VehicleDataSourceImpl({
    required this.supabaseClient,
  });

  @override
  Future<List<Map<String, dynamic>>> fetchAllVehicles() async {
    try {
      final response = await supabaseClient.from('vehicles').select();

      // final vehicles = response.map((e) => VehicleModel.fromJson(e)).toList();

      return response;
    } on PostgrestException catch (e) {
      throw Failure(e.message);
    } on Exception catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<List<Map<String, dynamic>>> fetchAllVehiclesByStore({
    required String storeId,
  }) async {
    try {
      logD('store id in datasource impl $storeId');
      final response = await supabaseClient
          .from('vehicles')
          .select()
          .eq('store_id', storeId)
          .select();

      // final vehicles = response.map((e) => VehicleModel.fromJson(e)).toList();

      return response;
    } on PostgrestException catch (e) {
      throw Failure(e.message);
    } on Exception catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> insertVehicle(
      Map<String, dynamic> vehicle) async {
    try {
      final response = await supabaseClient
          .from('vehicles')
          .upsert(vehicle, onConflict: 'id')
          .select()
          .single();

      return response;
    } on PostgrestException catch (e) {
      logE('error in exception datasource impl method $e');
      throw Failure(e.message);
    } catch (e) {
      logE('error in exception datasource impl method $e');
      throw Failure(e.toString());
    }
  }

  @override
  Stream<List<Map<String, dynamic>>> streamAllVehiclesByStore(
      {required String storeId}) {
    try {
      // return Stream.value(storeId).switchMap((id) => supabaseClient
      //     .from('vehicles')
      //     .select()
      //     .eq('store_id', id)
      //     .asStream());

      final response = supabaseClient
          .from('vehicles')
          .select()
          .eq('store_id', storeId)
          .select()
          .asStream();

      logI(storeId);
      response.listen((data) {
        logI('data in datasource impl $data');
      });
      return response;
    } on PostgrestException catch (e) {
      throw Failure(e.message);
    } on Exception catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> fetchVehicleById({
    required String id,
  }) async {
    try {
      final response = await supabaseClient
          .from('vehicles')
          .select()
          .eq('id', id)
          .select()
          .single();
      return response;
    } on PostgrestException catch (e) {
      throw Failure(e.message);
    } on Exception catch (e) {
      throw Failure(e.toString());
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> buyOrRentVehicle(
      Map<String, dynamic> vehicleBuyRentRequest) async {
    logE('vehicleBuyRentRequest: $vehicleBuyRentRequest');
    try {
      final response = await supabaseClient
          .from('vehicle_requests')
          .upsert(vehicleBuyRentRequest, onConflict: 'vehicle_id, user_id')
          .select()
          .single();
      return response;
    } on PostgrestException catch (e) {
      logE('Error in buyOrRentVehicle: $e');
      throw Failure(e.message);
    } on Exception catch (e) {
      logE('Error in buyOrRentVehicle: $e');
      throw Failure(e.toString());
    }
  }
}

//return Stream.value(storeId)
//             .switchMap((id) =>
//             supabaseClient
//                 .from('vehicles')
//                 .select()
//                 .eq('store_id', id)
//                 .asStream()
//         )
