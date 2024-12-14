import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/features/store/domain/repositories/store_repo.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_buy_rent_request_entity.dart';

part 'vehicle_request_for_store_state.dart';

class VehicleRequestForStoreCubit extends Cubit<VehicleRequestForStoreState> {
  final StoreRepo store;

  VehicleRequestForStoreCubit(this.store)
      : super(VehicleRequestForStoreInitial());

  Future<void> fetchStatusForVehicle({required String vehicleId}) async {
    emit(VehicleRequestForStoreLoading());
    try {
      final requests =
          await store.vehicleStatusFromRequest(vehicleId: vehicleId);
      requests.fold(
        (l) => emit(VehicleRequestForStoreError(l.message)),
        (r) => emit(VehicleRequestDetailsByVehicleIdSuccess(r)),
      );
    } catch (e) {
      emit(VehicleRequestForStoreError(e.toString()));
    }
  }

  Future<void> fetchRequests(String storeId) async {
    emit(VehicleRequestForStoreLoading());
    try {
      final requests = await store.vehicleRequestByStore(storeId: storeId);
      requests.fold(
        (l) => emit(VehicleRequestForStoreError(l.message)),
        (r) => emit(VehicleRequestForStoreSuccess(r)),
      );
    } catch (e) {
      emit(VehicleRequestForStoreError(e.toString()));
    }
  }

  Future<void> deleteRequest({
    required String storeId,
    required String requestId,
  }) async {
    emit(VehicleRequestForStoreLoading());
    try {
      final requests = await store.deleteVehicleRequestFromStore(
        storeId: storeId,
        requestId: requestId,
      );
      requests.fold(
        (l) => emit(VehicleRequestForStoreError(l.message)),
        (r) {
          fetchRequests(storeId);
        },
      );
    } catch (e) {
      emit(VehicleRequestForStoreError(e.toString()));
    }
  }

  Future<void> updateRequestStatus({
    required String requestId,
    required String status,
  }) async {
    emit(VehicleRequestForStoreLoading());
    try {
      final updatedRequest = await store.updateRequestStatus(
        requestId: requestId,
        status: status,
      );
      updatedRequest.fold(
        (l) => emit(VehicleRequestForStoreError(l.message)),
        // todo: fix the shady code
        // todo: fix the update not rebuilding the ui
        (r) => emit(VehicleRequestUpdateStatusSuccess(r)),
      );
    } catch (e) {
      emit(VehicleRequestForStoreError(e.toString()));
    }
  }
}
