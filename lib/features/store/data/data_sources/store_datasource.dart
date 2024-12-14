import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/store/domain/params/store_creation_params.dart';

abstract interface class StoreDataSource {
  Future<Either<Failure, Map<String, dynamic>>> createStore({
    required StoreCreationParams storeCreationParams,
  });

  /// Fetch User Stores
  Future<Either<Failure, List<Map<String, dynamic>>>> fetchUserStores();

  /// Fetch User Store by Id
  Future<Either<Failure, List<Map<String, dynamic>>>> fetchUserStoreById({
    required String storeId,
  });

  /// Fetch Store by Id
  Future<Either<Failure, List<Map<String, dynamic>>>> fetchStoreById({
    required String storeId,
  });

  /// Update Store
  Future<Either<Failure, Map<String, dynamic>>> updateStore({
    required Map<String, dynamic> storeJson,
  });

  /// Fetch Public Stores
  Future<Either<Failure, List<Map<String, dynamic>>>> fetchPublicStores();

  /// Delete Store by Id
  Future<Either<Failure, List<Map<String, dynamic>>>> deleteStoreById({
    required String storeId,
  });

  /// Fetch Vehicle Request by Store
  Future<Either<Failure, List<Map<String, dynamic>>>> vehicleRequestByStore({
    required String storeId,
  });

  /// Update Request Status
  Future<Either<Failure, List<Map<String, dynamic>>>> updateRequestStatus({
    required String requestId,
    required String status,
  });

  /// delete Request Status
  Future<Either<Failure, List<Map<String, dynamic>>>>
      deleteVehicleRequestFromStore({
    required String requestId,
    required String storeId,
  });

  Future<Either<Failure, Map<String, dynamic>>> vehicleStatusFromRequest({
    required String vehicleId,
  });
}
