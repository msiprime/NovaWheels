part of 'vehicle_bloc.dart';

@immutable
sealed class VehicleEvent {}

final class AllVehicleFetched extends VehicleEvent {}
