class StoreCreationParams {
  final String name;
  final String? description;
  final String? address;
  final String? phoneNumber;
  final String? email;
  final String? facebook;
  final String? instagram;
  final String? website;
  final String? coverImage;
  final String? profilePicture;

  StoreCreationParams({
    required this.name,
    this.description,
    this.address,
    this.phoneNumber,
    this.email,
    this.facebook,
    this.instagram,
    this.website,
    this.coverImage,
    this.profilePicture,
  });
}
