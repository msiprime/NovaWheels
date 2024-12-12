import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_buy_rent_request_entity.dart';

class VehicleBuyRentRequestModel {
  final String? id;
  final String vehicleId;
  final String userId;
  final String storeId;
  final String requestType;
  final List<int>? rentDays;
  final String mobileNumber;
  final String email;
  final String? secondMobileNumber;
  final String requestDate;
  final String status;
  final String? additionalDetails;

  VehicleBuyRentRequestModel({
    this.id,
    required this.vehicleId,
    required this.userId,
    required this.storeId,
    required this.requestType,
    this.rentDays,
    required this.mobileNumber,
    required this.email,
    this.secondMobileNumber,
    required this.requestDate,
    required this.status,
    this.additionalDetails,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'vehicle_id': vehicleId,
      'user_id': userId,
      'store_id': storeId,
      'request_type': requestType,
      'rent_days': rentDays,
      'mobile_number': mobileNumber,
      'email': email,
      'second_mobile_number': secondMobileNumber,
      'request_date': requestDate,
      'status': status,
      'additional_details': additionalDetails,
    };
  }

  factory VehicleBuyRentRequestModel.fromMap(Map<String, dynamic> map) {
    return VehicleBuyRentRequestModel(
      id: map['id'],
      vehicleId: map['vehicle_id'],
      userId: map['user_id'],
      storeId: map['store_id'],
      requestType: map['request_type'],
      rentDays:
          map['rent_days'] != null ? List<int>.from(map['rent_days']) : null,
      mobileNumber: map['mobile_number'],
      email: map['email'],
      secondMobileNumber: map['second_mobile_number'],
      requestDate: map['request_date'],
      status: map['status'],
      additionalDetails: map['additional_details'],
    );
  }
}

extension VehicleBuyRentRequestModelExtension on VehicleBuyRentRequestModel {
  VehicleBuyRentRequestEntity toEntity() {
    return VehicleBuyRentRequestEntity(
      id: id,
      vehicleId: vehicleId,
      userId: userId,
      storeId: storeId,
      requestType: requestType,
      rentDays: rentDays,
      mobileNumber: mobileNumber,
      email: email,
      secondMobileNumber: secondMobileNumber,
      requestDate: requestDate,
      status: status,
      additionalDetails: additionalDetails,
    );
  }
}
