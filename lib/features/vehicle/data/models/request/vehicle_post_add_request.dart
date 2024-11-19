import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_post_input.dart';

class VehicleModel extends VehicleEntity {
  const VehicleModel({
    required super.id,
    required super.storeId,
    required super.title,
    super.description,
    required super.isForRent,
    required super.isForSale,
    super.rentPrice,
    super.salePrice,
    required super.brand,
    required super.model,
    super.year,
    super.mileage,
    super.fuelType,
    super.transmission,
    required super.status,
    super.rentalStatus,
    super.images,
    super.location,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'],
      storeId: json['store_id'],
      title: json['title'],
      description: json['description'],
      isForRent: json['is_for_rent'],
      isForSale: json['is_for_sale'],
      rentPrice: json['rent_price']?.toDouble(),
      salePrice: json['sale_price']?.toDouble(),
      brand: json['brand'],
      model: json['model'],
      year: json['year'],
      mileage: json['mileage'],
      fuelType: json['fuel_type'],
      transmission: json['transmission'],
      status: json['status'],
      rentalStatus: json['rental_status'],
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'store_id': storeId,
      'title': title,
      'description': description,
      'is_for_rent': isForRent,
      'is_for_sale': isForSale,
      'rent_price': rentPrice,
      'sale_price': salePrice,
      'brand': brand,
      'model': model,
      'year': year,
      'mileage': mileage,
      'fuel_type': fuelType,
      'transmission': transmission,
      'status': status,
      'rental_status': rentalStatus,
      'images': images,
      'location': location,
    };
  }
}
