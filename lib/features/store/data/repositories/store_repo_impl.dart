import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/store/data/data_sources/store_datasource.dart';
import 'package:nova_wheels/features/store/data/models/store_model.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/features/store/domain/params/store_creation_params.dart';
import 'package:nova_wheels/features/store/domain/repositories/store_repo.dart';
import 'package:nova_wheels/features/vehicle/data/models/request/vehicle_buy_rent_request_model.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_buy_rent_request_entity.dart';

class StoreRepoImpl implements StoreRepo {
  final StoreDataSource storeDataSource;

  StoreRepoImpl({
    required this.storeDataSource,
  });

  @override
  Future<Either<Failure, StoreEntity>> createStore({
    required StoreCreationParams storeCreationParams,
  }) async {
    final response = await storeDataSource.createStore(
      storeCreationParams: storeCreationParams,
    );

    return response.fold(
      (failure) => Left(failure),
      (mapResponse) {
        final storeModel = StoreModel.fromJson(mapResponse);
        return Right(storeModel.toEntity());
      },
    );
  }

  @override
  Future<Either<Failure, List<StoreEntity>>> fetchUserStores() async {
    final response = await storeDataSource.fetchUserStores();

    return response.fold(
      (failure) => Left(failure),
      (listMapResponse) {
        final List<StoreEntity> listStoreModel = listMapResponse
            .map((map) => StoreModel.fromJson(map).toEntity())
            .toList();
        return Right(listStoreModel);
      },
    );
  }

  @override
  Future<Either<Failure, List<StoreEntity>>> fetchPublicStores() async {
    final response = await storeDataSource.fetchPublicStores();

    return response.fold(
      (failure) => Left(failure),
      (listMapResponse) {
        final List<StoreEntity> listStoreModel = listMapResponse
            .map((map) => StoreModel.fromJson(map).toEntity())
            .toList();
        return Right(listStoreModel);
      },
    );
  }

  @override
  Future<Either<Failure, List<StoreEntity>>> deleteStoreById({
    required String storeId,
  }) async {
    final response = await storeDataSource.deleteStoreById(storeId: storeId);

    return response.fold(
      (failure) => Left(failure),
      (listMapResponse) {
        final List<StoreEntity> listStoreModel = listMapResponse
            .map((map) => StoreModel.fromJson(map).toEntity())
            .toList();
        return Right(listStoreModel);
      },
    );
  }

  @override
  Future<Either<Failure, List<StoreEntity>>> fetchUserStoreById(
      {required String storeId}) async {
    final response = await storeDataSource.fetchUserStoreById(storeId: storeId);

    return response.fold(
      (failure) => Left(failure),
      (listMapResponse) {
        final List<StoreEntity> listStoreModel = listMapResponse
            .map((map) => StoreModel.fromJson(map).toEntity())
            .toList();
        return Right(listStoreModel);
      },
    );
  }

  @override
  Future<Either<Failure, StoreEntity>> updateStore(
      {required StoreEntity store}) async {
    Map<String, dynamic> updateMap = {
      'id': store.id,
      'name': store.name,
      'description': store.description,
      'is_verified': store.isVerified,
      'address': store.address,
      'phone_number': store.phoneNumber,
      'email': store.email,
      'twitter': store.twitter,
      'facebook': store.facebook,
      'instagram': store.instagram,
      'website': store.website,
      'cover_image': store.coverImage,
      'profile_picture': store.profilePicture,
    };

    final response = await storeDataSource.updateStore(storeJson: updateMap);

    return response.fold(
      (failure) => Left(failure),
      (mapResponse) {
        final storeModel = StoreModel.fromJson(mapResponse);
        return Right(storeModel.toEntity());
      },
    );
  }

  @override
  Future<Either<Failure, List<VehicleBuyRentRequestEntity>>>
      vehicleRequestByStore({
    required String storeId,
  }) async {
    final response =
        await storeDataSource.vehicleRequestByStore(storeId: storeId);

    return response.fold(
      (failure) => Left(failure),
      (listMapResponse) {
        final List<VehicleBuyRentRequestEntity> listOfVehicleRequest =
            listMapResponse
                .map(
                    (map) => VehicleBuyRentRequestModel.fromMap(map).toEntity())
                .toList();
        return Right(listOfVehicleRequest);
      },
    );
  }

  @override
  Future<Either<Failure, List<StoreEntity>>> fetchStoreById({
    required String storeId,
  }) async {
    final response = await storeDataSource.fetchStoreById(storeId: storeId);

    return response.fold(
      (failure) => Left(failure),
      (listMapResponse) {
        final List<StoreEntity> listStoreModel = listMapResponse
            .map((map) => StoreModel.fromJson(map).toEntity())
            .toList();
        return Right(listStoreModel);
      },
    );
  }

  @override
  Future<Either<Failure, VehicleBuyRentRequestEntity>> updateRequestStatus({
    required String requestId,
    required String status,
  }) async {
    final response = await storeDataSource.updateRequestStatus(
      requestId: requestId,
      status: status,
    );
    return response.fold(
      (failure) => Left(failure),
      (listMapResponse) {
        final VehicleBuyRentRequestEntity updatedVehicleRequest =
            VehicleBuyRentRequestModel.fromMap(listMapResponse).toEntity();
        return Right(updatedVehicleRequest);
      },
    );
  }
}
