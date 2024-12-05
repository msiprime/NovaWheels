import 'package:nova_wheels/features/profile/data/models/profile_model.dart';

abstract interface class ProfileDataSource {
  Future<ProfileModel> fetchProfile();

  Future<ProfileModel> updateProfile({
    required String fullName,
    required String userName,
    required String email,
    required String mobileNumber,
    required String website,
    required String avatarUrl,
  });
}
