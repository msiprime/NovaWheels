part of 'post_vehicle_bloc.dart';

// @immutable
sealed class PostVehicleEvent extends Equatable {}

class VehiclePostRequested extends PostVehicleEvent {
  final VehicleRequestEntity vehicleEntity;
  final List<String?> images;

  VehiclePostRequested({
    this.images = const [],
    required this.vehicleEntity,
  });

  @override
  List<Object?> get props => [vehicleEntity, images];
}
