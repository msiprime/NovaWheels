class StoreEntity {
  final String id;
  final String? ownerId;
  final String name;
  final String? description;
  final bool isVerified;
  final String? address;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? phoneNumber;
  final String? email;
  final String? facebook;
  final String? instagram;
  final String? website;
  final String? coverImage;
  final String? profilePicture;

  const StoreEntity({
    required this.id,
    this.ownerId,
    required this.name,
    this.description,
    this.isVerified = false,
    this.address,
    required this.createdAt,
    required this.updatedAt,
    this.phoneNumber,
    this.email,
    this.facebook,
    this.instagram,
    this.website,
    this.coverImage,
    this.profilePicture,
  });
}
