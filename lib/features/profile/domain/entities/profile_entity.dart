class ProfileEntity {
  final String id;
  final String email;
  final String userName;
  final String fullName;
  final String mobileNumber;
  final String? avatarUrl;
  final String? website;

  // final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isVerified;

  ProfileEntity({
    required this.id,
    required this.email,
    required this.userName,
    required this.fullName,
    required this.mobileNumber,
    this.avatarUrl,
    this.website,
    // this.createdAt,
    this.updatedAt,
    required this.isVerified,
  });
}
