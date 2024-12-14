import 'package:equatable/equatable.dart';

class VehicleBuyRentRequestEntity extends Equatable {
  final String? id;
  final String vehicleId;
  final String userId;
  final String storeId;
  final String requestType;
  final String? startDate;
  final String? endDate;
  final String mobileNumber;
  final String email;
  final String? secondMobileNumber;
  final String requestDate;
  final String status;
  final String? additionalDetails;

  const VehicleBuyRentRequestEntity({
    this.id,
    required this.vehicleId,
    required this.userId,
    required this.storeId,
    required this.requestType,
    this.startDate,
    this.endDate,
    required this.mobileNumber,
    required this.email,
    this.secondMobileNumber,
    required this.requestDate,
    required this.status,
    this.additionalDetails,
  });

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'vehicle_id': vehicleId,
      'user_id': userId,
      'store_id': storeId,
      'request_type': requestType,
      'start_date': startDate,
      'end_date': endDate,
      'mobile_number': mobileNumber,
      'email': email,
      'second_mobile_number': secondMobileNumber,
      // 'request_date': requestDate,
      'status': 'pending',
      'additional_details': additionalDetails,
    };
  }

  factory VehicleBuyRentRequestEntity.fromMap(Map<String, dynamic> map) {
    return VehicleBuyRentRequestEntity(
      id: map['id'],
      vehicleId: map['vehicle_id'],
      userId: map['user_id'],
      storeId: map['store_id'],
      requestType: map['request_type'],
      startDate: map['start_date'],
      endDate: map['end_date'],
      mobileNumber: map['mobile_number'],
      email: map['email'],
      secondMobileNumber: map['second_mobile_number'],
      requestDate: map['request_date'],
      status: map['status'],
      additionalDetails: map['additional_details'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        vehicleId,
        userId,
        storeId,
        requestType,
        startDate,
        endDate,
        mobileNumber,
        email,
        secondMobileNumber,
        requestDate,
        status,
        additionalDetails,
      ];
}
