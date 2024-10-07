part of 'vehicle_bloc.dart';

@immutable
sealed class VehicleState {}

final class VehicleInitial extends VehicleState {}

final class VehicleLoading extends VehicleState {}

final class VehicleLoaded extends VehicleState {
  final List<VehicleEntity> vehicles;

  VehicleLoaded({required this.vehicles});
}

final class VehicleError extends VehicleState {
  final String message;

  VehicleError({required this.message});
}
