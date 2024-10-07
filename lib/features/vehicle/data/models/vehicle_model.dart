import 'package:nova_wheels/features/vehicle/data/models/image_model.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/image_entity.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/vehicle_entity.dart';
import 'package:nova_wheels/shared/utils/mapper/base_mapper.dart';

class VehicleModel implements BaseMapper<VehicleEntity> {
  String? id;
  String? storeId;
  String? category;
  String? brand;
  String? model;
  int? year;
  double? price;
  String? description;
  ImagesModel? images;
  String? createdAt;
  String? updatedAt;
  double? rentPrice;
  String? status;
  String? vehicleCategory;

  VehicleModel({
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

  VehicleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    storeId = json['store_id'] ?? '';
    category = json['category'] ?? '';
    brand = json['brand'] ?? '';
    model = json['model'] ?? '';
    year = json['year'] as int;
    price = json['price'] as double?;
    description = json['description'] ?? '';
    images =
        json['images'] != null ? ImagesModel.fromJson(json['images']) : null;
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    rentPrice = json['rent_price'] as double;
    status = json['status'] ?? '';
    vehicleCategory = json['vehicle_category'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['store_id'] = storeId;
    data['category'] = category;
    data['brand'] = brand;
    data['model'] = model;
    data['year'] = year;
    data['price'] = price;
    data['description'] = description;
    if (images != null) {
      data['images'] = images!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['rent_price'] = rentPrice;
    data['status'] = status;
    data['vehicle_category'] = vehicleCategory;
    return data;
  }

  @override
  VehicleEntity mapToEntity() {
    return VehicleEntity(
      id: id,
      storeId: storeId,
      category: category,
      brand: brand,
      model: model,
      year: year,
      price: price,
      description: description,
      images:
          images != null ? ImageEntity(coverPhoto: images!.coverPhoto) : null,
      createdAt: createdAt,
      updatedAt: updatedAt,
      rentPrice: rentPrice,
      status: status,
      vehicleCategory: vehicleCategory,
    );
  }
}
