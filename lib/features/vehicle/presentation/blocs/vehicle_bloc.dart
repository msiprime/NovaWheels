import 'dart:async';

import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/vehicle_entity.dart';
import 'package:nova_wheels/features/vehicle/domain/use_cases/store_vehicle_usecase.dart';
import 'package:nova_wheels/features/vehicle/domain/use_cases/vehicle_usecase.dart';

part 'vehicle_event.dart';
part 'vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final VehicleUseCase vehicleUseCase;
  final VehicleByStoreUsecase storeVehicleUsecase;

  VehicleBloc({
    required this.storeVehicleUsecase,
    required this.vehicleUseCase,
  }) : super(VehicleInitial()) {
    on<VehicleEvent>(_onAllVehiclesFetched);
    on<VehicleByStoreFetched>(_onVehicleByStoreFetched);
  }

  FutureOr<void> _onAllVehiclesFetched(event, emit) async {
    emit(VehicleLoading());
    final result = await vehicleUseCase();
    result.fold(
      (failure) => emit(VehicleError(message: failure.message)),
      (vehicles) => emit(VehicleLoaded(vehicles: vehicles)),
    );
  }

  FutureOr<void> _onVehicleByStoreFetched(
      VehicleByStoreFetched event, Emitter<VehicleState> emit) async {
    emit(VehicleLoading());
    final result = await storeVehicleUsecase(
      storeId: event.storeId,
    );
    result.fold(
      (failure) => emit(VehicleError(message: failure.message)),
      (vehicles) => emit(VehicleLoaded(vehicles: vehicles)),
    );
  }
}
