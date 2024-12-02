import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_post_input.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_reponse_entity.dart';
import 'package:nova_wheels/features/vehicle/domain/use_cases/store_vehicle_usecase.dart';
import 'package:nova_wheels/features/vehicle/domain/use_cases/stream_of_store_vehicles.dart';
import 'package:nova_wheels/features/vehicle/domain/use_cases/vehicle_usecase.dart';
import 'package:shared/shared.dart';

part 'fetch_vehicle_event.dart';
part 'fetch_vehicle_state.dart';

class FetchVehicleBloc extends Bloc<FetchVehicleEvent, FetchVehicleState> {
  final VehicleUseCase vehicleUseCase;
  final VehicleByStoreUsecase storeVehicleUsecase;
  final StreamOfStoreVehiclesUsecase _streamOfStoreVehicleUsecase;

  FetchVehicleBloc({
    required this.storeVehicleUsecase,
    required this.vehicleUseCase,
    required StreamOfStoreVehiclesUsecase streamOfStoreVehiclesUsecase,
  })  : _streamOfStoreVehicleUsecase = streamOfStoreVehiclesUsecase,
        super(FetchVehicleInitial()) {
    on<FetchVehicleEvent>(_onAllVehiclesFetched, transformer: droppable());
    on<VehicleByStoreFetched>(_onVehicleByStoreFetched);
    on<StreamOfVehicleByStoreFetched>(_onStreamOfVehicleByStoreFetched,
        transformer: droppable());
  }

  FutureOr<void> _onAllVehiclesFetched(event, emit) async {
    emit(FetchVehicleLoading());
    final result = await vehicleUseCase();
    result.fold(
      (failure) => emit(FetchVehicleError(message: failure.message)),
      (vehicles) => emit(FetchVehicleLoaded(vehicles: vehicles)),
    );
  }

  FutureOr<void> _onVehicleByStoreFetched(
      VehicleByStoreFetched event, Emitter<FetchVehicleState> emit) async {
    emit(FetchVehicleLoading());
    try {
      final result = await storeVehicleUsecase(
        storeId: event.storeId,
      );
      result.fold(
        (failure) => emit(FetchVehicleError(message: failure.message)),
        (vehicles) => emit(FetchVehicleLoaded(vehicles: vehicles)),
      );
    } catch (e) {
      emit(FetchVehicleError(message: e.toString()));
    }
  }

  // FutureOr<void> _onStreamOfVehicleByStoreFetched(
  //     StreamOfVehicleByStoreFetched event, Emitter<FetchVehicleState> emit) {
  //   emit(FetchVehicleLoading());
  //   final stream = _streamOfStoreVehicleUsecase(storeId: event.storeId);
  //   stream.listen(
  //     (result) => result.fold(
  //       (failure) => emit(FetchVehicleError(message: failure.message)),
  //       (vehicles) => emit(FetchVehicleLoaded(vehicles: vehicles)),
  //     ),
  //   );
  // }

  Future<void> _onStreamOfVehicleByStoreFetched(
    StreamOfVehicleByStoreFetched event,
    Emitter<FetchVehicleState> emit,
  ) async {
    emit(FetchVehicleLoading());

    try {
      final stream = _streamOfStoreVehicleUsecase(storeId: event.storeId);
      await emit.forEach(
        stream,
        onData: (result) => result.fold(
          (failure) => FetchVehicleError(message: failure.message),
          (vehicles) {
            /// printing the fetched vehicles
            logD('Vehicle fetched in bloc: $vehicles');
            return FetchVehicleLoaded(vehicles: vehicles);
          },
        ),
        onError: (error, stackTrace) =>
            FetchVehicleError(message: error.toString()),
      );
    } catch (e) {
      emit(FetchVehicleError(message: e.toString()));
    }
  }
}
