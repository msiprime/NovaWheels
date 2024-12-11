import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_reponse_entity.dart';
import 'package:nova_wheels/features/vehicle/domain/use_cases/vehicle_by_id_usecase.dart';

part 'vehicle_details_state.dart';

class VehicleDetailsCubit extends Cubit<VehicleDetailsState> {
  VehicleDetailsCubit({
    required VehicleByIdUsecase vehicleByIdUsecase,
  })  : _vehicleByIdUsecase = vehicleByIdUsecase,
        super(VehicleDetailsInitial());

  final VehicleByIdUsecase _vehicleByIdUsecase;

  void fetchVehicleById(String id) async {
    emit(VehicleDetailsLoading());
    try {
      final vehicle = await _vehicleByIdUsecase.call(id: id);
      vehicle.fold(
        (failure) => emit(VehicleDetailsError(message: failure.message)),
        (vehicle) => emit(VehicleDetailsLoaded(vehicle: vehicle)),
      );
    } catch (e) {
      emit(VehicleDetailsError(message: e.toString()));
    }
  }
}
