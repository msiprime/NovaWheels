import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/features/profile/domain/entities/profile_entity.dart';
import 'package:nova_wheels/features/profile/domain/repositories/profile_repository.dart';

part 'profile_of_requester_state.dart';

class ProfileOfRequesterCubit extends Cubit<ProfileOfRequesterState> {
  ProfileRepository profileRepository;

  ProfileOfRequesterCubit({
    required this.profileRepository,
  }) : super(ProfileOfRequesterInitial());

  Future<void> fetchProfileDataById({
    required String id,
  }) async {
    emit(ProfileOfRequesterLoading());
    try {
      final profileData = await profileRepository.getProfileDataById(
        profileId: id,
      );
      profileData.fold(
        (l) => emit(ProfileOfRequesterError(l.message)),
        (r) => emit(ProfileOfRequesterSuccess(r)),
      );
    } catch (e) {
      emit(ProfileOfRequesterError(e.toString()));
    }
  }
}
