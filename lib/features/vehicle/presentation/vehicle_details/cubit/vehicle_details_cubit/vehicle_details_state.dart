part of 'vehicle_details_cubit.dart';

@immutable
sealed class VehicleDetailsState {}

final class VehicleDetailsInitial extends VehicleDetailsState {}

final class VehicleDetailsLoading extends VehicleDetailsState {}

final class VehicleDetailsLoaded extends VehicleDetailsState {
  final VehicleResponseEntity vehicle;

  VehicleDetailsLoaded({
    required this.vehicle,
  });
}

final class VehicleDetailsError extends VehicleDetailsState {
  final String message;

  VehicleDetailsError({
    required this.message,
  });
}
