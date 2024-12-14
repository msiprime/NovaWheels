import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/store/data/data_sources/store_datasource.dart';
import 'package:nova_wheels/features/store/domain/params/store_creation_params.dart';
import 'package:shared/shared.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StoreDataSourceImpl implements StoreDataSource {
  final SupabaseClient supabaseClient;

  StoreDataSourceImpl({required this.supabaseClient});

  @override
  Future<Either<Failure, Map<String, dynamic>>> createStore({
    required StoreCreationParams storeCreationParams,
  }) async {
    try {
      final response = await supabaseClient
          .from('stores')
          .insert([
            {
              'name': storeCreationParams.name,
              'owner_id': supabaseClient.auth.currentUser!.id,
              'description': storeCreationParams.description,
              'address': storeCreationParams.address,
              'phone_number': storeCreationParams.phoneNumber,
              'email': storeCreationParams.email,
              'facebook': storeCreationParams.facebook,
              'instagram': storeCreationParams.instagram,
              'website': storeCreationParams.website,
              'cover_image': storeCreationParams.coverImage,
              'profile_picture': storeCreationParams.profilePicture,
            }
          ])
          .select()
          .single();

      if (response.isEmpty) {
        return Left(ServerFailure('Failed to create store'));
      }

      return Right(response);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> fetchUserStores() async {
    try {
      final response = await supabaseClient
          .from('stores')
          .select()
          .eq('owner_id', supabaseClient.auth.currentUser!.id);
      if (response.isEmpty) {
        return Left(ServerFailure('No Store Found!'));
      }

      return Right(response);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>>
      fetchPublicStores() async {
    try {
      final response = await supabaseClient.from('stores').select();

      if (response.isEmpty) {
        return Left(ServerFailure('No Store Found!'));
      }

      return Right(response);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> deleteStoreById(
      {required String storeId}) async {
    try {
      final response = await supabaseClient
          .from('stores')
          .delete()
          .eq('owner_id', supabaseClient.auth.currentUser!.id)
          .eq('id', storeId)
          .select();

      if (response.isEmpty) {
        return Left(ServerFailure('Failed to create store'));
      }

      return Right(response);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> fetchUserStoreById({
    required String storeId,
  }) async {
    try {
      final response = await supabaseClient
          .from('stores')
          .select()
          .eq('owner_id', supabaseClient.auth.currentUser!.id)
          .eq('id', storeId);

      if (response.isEmpty) {
        return Left(ServerFailure('No Store Found!'));
      }

      return Right(response);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> updateStore(
      {required Map<String, dynamic> storeJson}) async {
    try {
      final response = await supabaseClient
          .from('stores')
          .update(storeJson)
          .eq('owner_id', supabaseClient.auth.currentUser!.id)
          .eq('id', storeJson['id'])
          .select()
          .single();

      if (response.isEmpty) {
        return Left(ServerFailure('Failed to update store'));
      }

      return Right(response);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> vehicleRequestByStore({
    required String storeId,
  }) async {
    try {
      final response = await supabaseClient
          .from('vehicle_requests')
          .select()
          .eq('store_id', storeId);

      if (response.isEmpty) {
        return Left(ServerFailure('No Request In Store!'));
      }

      return Right(response);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> fetchStoreById({
    required String storeId,
  }) async {
    try {
      final response =
          await supabaseClient.from('stores').select().eq('id', storeId);

      if (response.isEmpty) {
        return Left(ServerFailure('No Store Found!'));
      }

      return Right(response);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> updateRequestStatus({
    required String requestId,
    required String status,
  }) async {
    try {
      final response = await supabaseClient
          .from('vehicle_requests')
          .update({'status': status})
          .eq('id', requestId)
          .select();
      return Right(response);
    } on PostgrestException catch (e) {
      logE(e.details);
      logE(e.message);
      logE(e.code);
      logE(e.hint);
      logE(e.toJson());
      return Left(ServerFailure(e.message));
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>>
      deleteVehicleRequestFromStore({
    required String requestId,
    required String storeId,
  }) async {
    try {
      final response =
          await supabaseClient.from('vehicle_requests').delete().match({
        'id': requestId,
        'store_id': storeId,
      }).select();

      if (response.isEmpty) {
        return Left(ServerFailure('Server Error Found!'));
      }

      return Right(response);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> vehicleStatusFromRequest({
    required String vehicleId,
  }) async {
    try {
      final response = await supabaseClient
          .from('vehicle_requests')
          .select()
          .eq('vehicle_id', vehicleId);

      if (response.isEmpty) {
        return Left(ServerFailure('Server Error Found!'));
      }

      return Right(response.first);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
