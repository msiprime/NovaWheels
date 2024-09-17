class User {
  final String id;
  final String fullName;
  final String? email;
  final String? mobileNumber;
  final String? avatarImage;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    this.mobileNumber,
    this.avatarImage,
  });
}
