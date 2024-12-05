import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/core/base_component/usecase/base_use_case.dart';
import 'package:nova_wheels/features/profile/domain/entities/profile_entity.dart';
import 'package:nova_wheels/features/profile/domain/usecases/profile_data_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileDataUsecase _profileDataUsecase;
  final UpdateProfileDataUsecase _updateProfileDataUsecase;

  ProfileBloc({
    required ProfileDataUsecase profileDataUsecase,
    required UpdateProfileDataUsecase updateProfileDataUsecase,
  })  : _profileDataUsecase = profileDataUsecase,
        _updateProfileDataUsecase = updateProfileDataUsecase,
        super(ProfileInitial()) {
    on<GetProfileDataEvent>(_onGetProfileData);
    on<UpdateProfileDataEvent>(_onUpdateProfileData);
  }

  Future<FutureOr<void>> _onGetProfileData(
    GetProfileDataEvent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(ProfileLoading());
      await _profileDataUsecase(NoParams()).then((response) {
        response.fold(
          (failure) => emit(ProfileError(failure.message)),
          (profile) => emit(ProfileSuccess(profileEntity: profile)),
        );
      });
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<FutureOr<void>> _onUpdateProfileData(
      UpdateProfileDataEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoading());

      final response = await _updateProfileDataUsecase(UpdateProfileParams(
        fullName: event.fullName,
        userName: event.userName,
        email: event.email,
        mobileNumber: event.mobileNumber,
        website: event.website,
        avatarUrl: event.avatarUrl,
      ));

      response.fold(
        (failure) {
          emit(ProfileError(failure.message));
        },
        (profile) => emit(ProfileSuccess(profileEntity: profile)),
      );
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
