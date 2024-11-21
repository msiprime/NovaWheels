part of 'post_vehicle_bloc.dart';

@immutable
sealed class PostVehicleEvent {}

class VehiclePostRequested extends PostVehicleEvent {
  final VehicleRequestEntity vehicleEntity;

  VehiclePostRequested({
    required this.vehicleEntity,
  });
}
