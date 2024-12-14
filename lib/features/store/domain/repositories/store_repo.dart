import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/features/store/domain/params/store_creation_params.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_buy_rent_request_entity.dart';

abstract interface class StoreRepo {
  /// Create Store
  Future<Either<Failure, StoreEntity>> createStore({
    required StoreCreationParams storeCreationParams,
  });

  /// Fetch User Stores
  Future<Either<Failure, List<StoreEntity>>> fetchUserStores();

  /// Fetch User Store by Id
  Future<Either<Failure, List<StoreEntity>>> fetchUserStoreById({
    required String storeId,
  });

  /// Fetch Store by Id
  Future<Either<Failure, List<StoreEntity>>> fetchStoreById({
    required String storeId,
  });

  /// Update Store
  Future<Either<Failure, StoreEntity>> updateStore({
    required StoreEntity store,
  });

  /// Fetch Public Stores
  Future<Either<Failure, List<StoreEntity>>> fetchPublicStores();

  /// Delete Store by Id
  Future<Either<Failure, List<StoreEntity>>> deleteStoreById({
    required String storeId,
  });

  /// Fetch Vehicle Request by Store
  Future<Either<Failure, List<VehicleBuyRentRequestEntity>>>
      vehicleRequestByStore({
    required String storeId,
  });

  /// Update Request Status
  Future<Either<Failure, List<VehicleBuyRentRequestEntity>>>
      updateRequestStatus({
    required String requestId,
    required String status,
  });

  /// Fetch Vehicle Request by Store
  Future<Either<Failure, List<VehicleBuyRentRequestEntity>>>
      deleteVehicleRequestFromStore({
    required String storeId,
    required String requestId,
  });

  Future<Either<Failure, VehicleBuyRentRequestEntity>>
      vehicleStatusFromRequest({
    required String vehicleId,
  });
}
