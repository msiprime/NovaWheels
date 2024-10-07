import 'package:nova_wheels/features/vehicle/domain/entities/image_entity.dart';

class VehicleEntity {
  String? id;
  String? storeId;
  String? category;
  String? brand;
  String? model;
  int? year;
  double? price;
  String? description;
  ImageEntity? images;
  String? createdAt;
  String? updatedAt;
  double? rentPrice;
  String? status;
  String? vehicleCategory;

  VehicleEntity({
    this.id,
    this.storeId,
    this.category,
    this.brand,
    this.model,
    this.year,
    this.price,
    this.description,
    this.images,
    this.createdAt,
    this.updatedAt,
    this.rentPrice,
    this.status,
    this.vehicleCategory,
  });
}
