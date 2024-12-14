part of 'vehicle_request_for_store_cubit.dart';

@immutable
sealed class VehicleRequestForStoreState {}

final class VehicleRequestForStoreInitial extends VehicleRequestForStoreState {}

final class VehicleRequestForStoreLoading extends VehicleRequestForStoreState {}

final class VehicleRequestForStoreSuccess extends VehicleRequestForStoreState {
  final List<VehicleBuyRentRequestEntity> requests;

  VehicleRequestForStoreSuccess(this.requests);
}

final class VehicleRequestForStoreError extends VehicleRequestForStoreState {
  final String errorMessage;

  VehicleRequestForStoreError(this.errorMessage);
}
