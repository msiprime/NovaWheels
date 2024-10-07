import 'dart:async';

import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/vehicle_entity.dart';
import 'package:nova_wheels/features/vehicle/domain/use_cases/vehicle_usecase.dart';

part 'vehicle_event.dart';
part 'vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final VehicleUseCase vehicleUseCase;

  VehicleBloc({
    required this.vehicleUseCase,
  }) : super(VehicleInitial()) {
    on<VehicleEvent>(_onAllVehiclesFetched);
  }

  FutureOr<void> _onAllVehiclesFetched(event, emit) async {
    emit(VehicleLoading());
    final result = await vehicleUseCase();
    result.fold(
      (failure) => emit(VehicleError(message: failure.message)),
      (vehicles) => emit(VehicleLoaded(vehicles: vehicles)),
    );
  }
}
