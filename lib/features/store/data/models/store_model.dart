import 'package:equatable/equatable.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/shared/utils/mapper/base_mapper.dart';

class StoreModel extends Equatable implements BaseMapper<StoreEntity> {
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

  const StoreModel({
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

  @override
  List<Object?> get props => [
        id,
        ownerId,
        name,
        description,
        isVerified,
        address,
        createdAt,
        updatedAt,
        phoneNumber,
        email,
        facebook,
        instagram,
        website,
        coverImage,
        profilePicture,
      ];

  // Factory method to create a Store object from a JSON map (useful for fetching data)
  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'] as String,
      ownerId: json['owner_id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      isVerified: json['is_verified'] as bool? ?? false,
      address: json['address'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      phoneNumber: json['phone_number'] as String?,
      email: json['email'] as String?,
      facebook: json['facebook'] as String?,
      instagram: json['instagram'] as String?,
      website: json['website'] as String?,
      coverImage: json['cover_image'] as String?,
      profilePicture: json['profile_picture'] as String?,
    );
  }

  // Method to convert a Store object to a JSON map (useful for sending data)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'owner_id': ownerId,
      'name': name,
      'description': description,
      'is_verified': isVerified,
      'address': address,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'phone_number': phoneNumber,
      'email': email,
      'facebook': facebook,
      'instagram': instagram,
      'website': website,
      'cover_image': coverImage,
      'profile_picture': profilePicture,
    };
  }

  @override
  StoreEntity toEntity() {
    return StoreEntity(
      id: id,
      ownerId: ownerId,
      name: name,
      description: description,
      isVerified: isVerified,
      address: address,
      createdAt: createdAt,
      updatedAt: updatedAt,
      phoneNumber: phoneNumber,
      email: email,
      facebook: facebook,
      instagram: instagram,
      website: website,
      coverImage: coverImage,
      profilePicture: profilePicture,
    );
  }
}
