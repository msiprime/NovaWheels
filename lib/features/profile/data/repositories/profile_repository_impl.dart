import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/profile/data/datasources/profile_datasource.dart';
import 'package:nova_wheels/features/profile/data/models/profile_model.dart';
import 'package:nova_wheels/features/profile/domain/entities/profile_entity.dart';
import 'package:nova_wheels/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImp implements ProfileRepository {
  final ProfileDataSource profileDataSource;

  ProfileRepositoryImp({
    required this.profileDataSource,
  });

  @override
  Future<Either<Failure, ProfileEntity>> getProfileData() async {
    try {
      final profileData = await profileDataSource.fetchProfile();

      return Right(profileData.toEntity());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfileData({
    required String? fullName,
    required String? userName,
    required String? email,
    required String? mobileNumber,
    required String? website,
    required String? avatarUrl,
  }) async {
    try {
      final profileData = await profileDataSource.updateProfile(
        fullName: fullName ?? '',
        userName: userName ?? '',
        email: email ?? '',
        mobileNumber: mobileNumber ?? '',
        website: website ?? '',
        avatarUrl: avatarUrl ?? '',
      );
      return Right(profileData.toEntity());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
