part of 'fetch_vehicle_bloc.dart';

@immutable
sealed class FetchVehicleEvent {}

final class AllVehicleFetched extends FetchVehicleEvent {}

final class VehicleByStoreFetched extends FetchVehicleEvent {
  final String storeId;

  VehicleByStoreFetched({required this.storeId});
}

final class StreamOfVehicleByStoreFetched extends FetchVehicleEvent {
  final String storeId;

  StreamOfVehicleByStoreFetched({required this.storeId});
}

final class VehiclePostRequested extends FetchVehicleEvent {
  final VehicleRequestEntity vehicle;

  VehiclePostRequested({required this.vehicle});
}
