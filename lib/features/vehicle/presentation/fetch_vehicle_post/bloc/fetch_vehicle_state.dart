part of 'fetch_vehicle_bloc.dart';

@immutable
sealed class FetchVehicleState {}

final class FetchVehicleInitial extends FetchVehicleState {}

final class FetchVehicleLoading extends FetchVehicleState {}

final class FetchVehicleLoaded extends FetchVehicleState {
  final List<VehicleResponseEntity> vehicles;

  FetchVehicleLoaded({required this.vehicles});
}

final class FetchVehicleError extends FetchVehicleState {
  final String message;

  FetchVehicleError({required this.message});
}
