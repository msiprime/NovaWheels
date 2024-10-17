part of 'vehicle_bloc.dart';

@immutable
sealed class VehicleEvent {}

final class AllVehicleFetched extends VehicleEvent {}

final class VehicleByStoreFetched extends VehicleEvent {
  final String storeId;

  VehicleByStoreFetched({required this.storeId});
}
