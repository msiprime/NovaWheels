class VehicleEntity {
  final String id;
  final String storeId;
  final String title;
  final String? description;
  final bool isForRent;
  final bool isForSale;
  final double? rentPrice;
  final double? salePrice;
  final String brand;
  final String model;
  final String? year;
  final String? mileage;
  final String? fuelType;
  final String? transmission;
  final String status;
  final String? rentalStatus;
  final List<String>? images;
  final String? location;

  const VehicleEntity({
    required this.id,
    required this.storeId,
    required this.title,
    this.description,
    required this.isForRent,
    required this.isForSale,
    this.rentPrice,
    this.salePrice,
    required this.brand,
    required this.model,
    this.year,
    this.mileage,
    this.fuelType,
    this.transmission,
    required this.status,
    this.rentalStatus,
    this.images,
    this.location,
  });
}
