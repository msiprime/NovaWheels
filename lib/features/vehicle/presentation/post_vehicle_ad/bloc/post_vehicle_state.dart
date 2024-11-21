part of 'post_vehicle_bloc.dart';

@immutable
sealed class PostVehicleState {}

final class PostVehicleInitial extends PostVehicleState {}

final class PostVehicleLoading extends PostVehicleState {}

final class PostVehicleLoaded extends PostVehicleState {
  final VehicleResponseEntity vehicle;

  PostVehicleLoaded({required this.vehicle});
}

final class PostVehicleError extends PostVehicleState {
  final String message;

  PostVehicleError({required this.message});
}
