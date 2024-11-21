import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_post_input.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_reponse_entity.dart';
import 'package:nova_wheels/features/vehicle/domain/use_cases/post_vehicle_usecase.dart';
import 'package:shared/shared.dart';

part 'post_vehicle_event.dart';
part 'post_vehicle_state.dart';

class PostVehicleBloc extends Bloc<PostVehicleEvent, PostVehicleState> {
  final PostVehicleUseCase _postVehicleUseCase;

  PostVehicleBloc({required PostVehicleUseCase postVehicleUseCase})
      : _postVehicleUseCase = postVehicleUseCase,
        super(PostVehicleInitial()) {
    on<PostVehicleEvent>((event, emit) {});
    on<VehiclePostRequested>(_onVehiclePostRequested);
  }

  FutureOr<void> _onVehiclePostRequested(
      VehiclePostRequested event, Emitter<PostVehicleState> emit) async {
    emit(PostVehicleLoading());
    try {
      // final result = await _postVehicleUseCase(event.vehicleEntity);
      // result.fold(
      //   (failure) => emit(PostVehicleError(message: failure.message)),
      //   (vehicle) => emit(PostVehicleLoaded(vehicle: vehicle)),
      // );
    } catch (e) {
      logE('error in exception bloc method $e');
      emit(PostVehicleError(message: e.toString()));
    }
  }
}
