import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_buy_rent_request_entity.dart';
import 'package:nova_wheels/features/vehicle/domain/use_cases/vehicle_request_usecase.dart';

part 'vehicle_buy_rent_request_state.dart';

class VehicleBuyRentCubit extends Cubit<VehicleBuyRentState> {
  final VehicleRequestUsecase _requestUsecase;

  VehicleBuyRentCubit({required VehicleRequestUsecase vehicleRequestUsecase})
      : _requestUsecase = vehicleRequestUsecase,
        super(VehicleRequestInitial());

  Future<void> requestToBuy({
    required VehicleBuyRentRequestEntity requestEntity,
  }) async {
    emit(VehicleRequestLoading());
    try {
      final response =
          await _requestUsecase.call(vehicleRequest: requestEntity);

      response.fold(
        (failure) => emit(VehicleRequestFailure(failure.message)),
        (success) => emit(VehicleRequestSuccess(
            'Successfully requested to buy the vehicle.')),
      );
    } catch (e) {
      emit(VehicleRequestFailure(
          'Failed to request the vehicle. Please try again.'));
    }
  }

  Future<void> requestToRent({
    required VehicleBuyRentRequestEntity requestEntity,
  }) async {
    emit(VehicleRequestLoading());
    try {
      final response =
          await _requestUsecase.call(vehicleRequest: requestEntity);

      response.fold(
        (failure) => emit(VehicleRequestFailure(failure.message)),
        (success) => emit(VehicleRequestSuccess(
            'Successfully requested to buy the vehicle.')),
      );
    } catch (e) {
      emit(VehicleRequestFailure(
          'Failed to request the vehicle. Please try again.'));
    }
  }
}
