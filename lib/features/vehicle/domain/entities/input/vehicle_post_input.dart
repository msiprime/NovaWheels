class VehicleRequestEntity {
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
  final List<String>? images;
  final String? location;

  VehicleRequestEntity({
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
    this.images,
    this.location,
  });

  Map<String, dynamic> toJson() {
    return {
      'store_id': storeId,
      'title': title,
      'description': description,
      'is_for_rent': isForRent,
      'is_for_sale': isForSale,
      'rent_price': isForRent ? rentPrice : null,
      'sale_price': isForSale ? salePrice : null,
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
