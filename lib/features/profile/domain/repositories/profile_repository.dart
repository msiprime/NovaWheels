import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/profile/domain/entities/profile_entity.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfileData();

  Future<Either<Failure, ProfileEntity>> updateProfileData({
    required String? fullName,
    required String? userName,
    required String? email,
    required String? mobileNumber,
    required String? website,
    required String? avatarUrl,
  });
}
