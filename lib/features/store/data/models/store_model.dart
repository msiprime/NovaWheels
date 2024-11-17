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
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? phoneNumber;
  final String? email;
  final String? facebook;
  final String? instagram;
  final String? website;
  final String? coverImage;
  final String? profilePicture;
  final String? twitter;

  const StoreModel({
    this.twitter,
    required this.id,
    this.ownerId,
    required this.name,
    this.description,
    this.isVerified = false,
    this.address,
    this.createdAt,
    this.updatedAt,
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
      twitter: json['twitter'] as String?,
      coverImage: json['cover_image'] as String?,
      profilePicture: json['profile_picture'] as String?,
    );
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

  factory StoreModel.fromEntity(StoreEntity entity) {
    return StoreModel(
      id: entity.id,
      ownerId: entity.ownerId,
      name: entity.name,
      description: entity.description,
      isVerified: entity.isVerified,
      address: entity.address,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      phoneNumber: entity.phoneNumber,
      email: entity.email,
      facebook: entity.facebook,
      instagram: entity.instagram,
      website: entity.website,
      coverImage: entity.coverImage,
      profilePicture: entity.profilePicture,
      twitter: entity.twitter,
    );
  }

  StoreModel copyWith(
    String? id,
    String? ownerId,
    String? name,
    String? description,
    bool? isVerified,
    String? address,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? phoneNumber,
    String? email,
    String? facebook,
    String? instagram,
    String? website,
    String? coverImage,
    String? profilePicture,
    String? twitter,
  ) {
    return StoreModel(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      name: name ?? this.name,
      description: description ?? this.description,
      isVerified: isVerified ?? this.isVerified,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      facebook: facebook ?? this.facebook,
      instagram: instagram ?? this.instagram,
      website: website ?? this.website,
      coverImage: coverImage ?? this.coverImage,
      profilePicture: profilePicture ?? this.profilePicture,
      twitter: twitter ?? this.twitter,
    );
  }
}
