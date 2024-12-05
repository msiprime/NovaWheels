import 'package:nova_wheels/features/profile/domain/entities/profile_entity.dart';

class ProfileModel {
  final String id;
  final String email;
  final String userName;
  final String mobileNumber;
  final String fullName;
  final String? avatarUrl;
  final String? website;
  final bool? isVerified;
  final DateTime? updatedAt;

  ProfileModel({
    required this.id,
    required this.email,
    required this.userName,
    required this.fullName,
    required this.mobileNumber,
    this.avatarUrl,
    this.website,
    this.isVerified,
    this.updatedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      userName: json['username'] ?? '',
      fullName: json['full_name'] ?? '',
      mobileNumber: json['phone_number'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      website: json['website'] ?? '',
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      isVerified: json['verified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': userName,
      'full_name': fullName,
      'phone_number': mobileNumber,
      'avatar_url': avatarUrl,
      'website': website,
      'updated_at': updatedAt,
      'verified': isVerified,
    };
  }
}

extension ProfileModelMapper on ProfileModel {
  ProfileEntity toEntity() {
    return ProfileEntity(
      id: id,
      email: email,
      userName: userName,
      fullName: fullName,
      mobileNumber: mobileNumber,
      avatarUrl: avatarUrl,
      website: website,
      updatedAt: updatedAt,
      isVerified: isVerified ?? false,
    );
  }
}

extension ProfileEntityMapper on ProfileEntity {
  ProfileModel toModel() {
    return ProfileModel(
      id: id,
      email: email,
      userName: userName,
      fullName: fullName,
      mobileNumber: mobileNumber,
      avatarUrl: avatarUrl,
      website: website,
      updatedAt: updatedAt,
      isVerified: isVerified,
    );
  }
}
