part of 'vehicle_buy_rent_request_cubit.dart';

@immutable
abstract class VehicleBuyRentState {}

class VehicleRequestInitial extends VehicleBuyRentState {}

class VehicleRequestLoading extends VehicleBuyRentState {}

class VehicleRequestSuccess extends VehicleBuyRentState {
  final String message;

  VehicleRequestSuccess(this.message);
}

class VehicleRequestFailure extends VehicleBuyRentState {
  final String errorMessage;

  VehicleRequestFailure(this.errorMessage);
}
