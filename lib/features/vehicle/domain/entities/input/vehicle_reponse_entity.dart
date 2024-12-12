class VehicleResponseEntity {
  final String id;
  final String storeId;
  final String title;
  final String? description;
  final bool isForRent;
  final bool isForSale;
  final String? rentPrice;
  final String? salePrice;
  final String? brand;
  final String? model;
  final String? year;
  final String? mileage;
  final String? fuelType;
  final String? transmission;
  final String status;
  final String? rentalStatus;
  final List<String> images;
  final String? location;
  final DateTime createdAt;
  final DateTime updatedAt;

  VehicleResponseEntity({
    required this.id,
    required this.storeId,
    required this.title,
    this.description,
    this.isForRent = false,
    this.isForSale = false,
    this.rentPrice,
    this.salePrice,
    this.brand,
    this.model,
    this.year,
    this.mileage,
    this.fuelType,
    this.transmission,
    this.status = 'available',
    this.rentalStatus,
    this.images = const [],
    this.location,
    required this.createdAt,
    required this.updatedAt,
  });

  // make from json

  factory VehicleResponseEntity.fromJson(Map<String, dynamic> json) {
    return VehicleResponseEntity(
      id: json['id'],
      storeId: json['store_id'],
      title: json['title'],
      description: json['description'],
      isForRent: json['is_for_rent'],
      isForSale: json['is_for_sale'],
      rentPrice: json['rent_price'],
      salePrice: json['sale_price'],
      brand: json['brand'],
      model: json['model'],
      year: json['year'],
      mileage: json['mileage'],
      fuelType: json['fuel_type'],
      transmission: json['transmission'],
      status: json['status'],
      rentalStatus: json['rental_status'],
      images: List<String>.from(json['images']),
      location: json['location'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
