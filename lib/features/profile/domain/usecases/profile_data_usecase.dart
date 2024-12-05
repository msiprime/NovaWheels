import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/core/base_component/usecase/base_use_case.dart';
import 'package:nova_wheels/features/profile/domain/entities/profile_entity.dart';
import 'package:nova_wheels/features/profile/domain/repositories/profile_repository.dart';

class ProfileDataUsecase
    implements BaseUseCase<Failure, ProfileEntity, NoParams> {
  final ProfileRepository profileRepository;

  ProfileDataUsecase({
    required this.profileRepository,
  });

  @override
  Future<Either<Failure, ProfileEntity>> call(NoParams params) {
    return profileRepository.getProfileData();
  }
}

class UpdateProfileDataUsecase
    implements BaseUseCase<Failure, ProfileEntity, UpdateProfileParams> {
  final ProfileRepository profileRepository;

  UpdateProfileDataUsecase({
    required this.profileRepository,
  });

  @override
  Future<Either<Failure, ProfileEntity>> call(UpdateProfileParams params) {
    return profileRepository.updateProfileData(
      fullName: params.fullName,
      userName: params.userName,
      email: params.email,
      mobileNumber: params.mobileNumber,
      website: params.website,
      avatarUrl: params.avatarUrl,
    );
  }
}

class UpdateProfileParams {
  final String? fullName;
  final String? userName;
  final String? email;
  final String? mobileNumber;
  final String? website;
  final String? avatarUrl;

  UpdateProfileParams({
    required this.fullName,
    required this.userName,
    required this.email,
    required this.mobileNumber,
    required this.website,
    required this.avatarUrl,
  });
}
