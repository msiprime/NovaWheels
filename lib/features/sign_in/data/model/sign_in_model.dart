import 'package:nova_wheels/features/sign_in/domain/entities/sign_in_entity.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.fullName,
    required super.email,
    super.mobileNumber,
    super.avatarImage,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      fullName: map['full_name'] as String,
      email: map['email'] as String?,
      mobileNumber: map['mobile_number'] as String?,
      avatarImage: map['avatar_url'] as String?,
    );
  }
}
