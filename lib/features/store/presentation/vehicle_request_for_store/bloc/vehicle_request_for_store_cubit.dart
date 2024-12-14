import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/features/store/domain/repositories/store_repo.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_buy_rent_request_entity.dart';

part 'vehicle_request_for_store_state.dart';

class VehicleRequestForStoreCubit extends Cubit<VehicleRequestForStoreState> {
  final StoreRepo store;

  VehicleRequestForStoreCubit(this.store)
      : super(VehicleRequestForStoreInitial());

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
}
