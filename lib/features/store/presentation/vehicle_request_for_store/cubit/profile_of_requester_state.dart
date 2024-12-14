part of 'profile_of_requester_cubit.dart';

@immutable
sealed class ProfileOfRequesterState {}

final class ProfileOfRequesterInitial extends ProfileOfRequesterState {}

final class ProfileOfRequesterLoading extends ProfileOfRequesterState {}

final class ProfileOfRequesterError extends ProfileOfRequesterState {
  final String errorMessage;

  ProfileOfRequesterError(this.errorMessage);
}

final class ProfileOfRequesterSuccess extends ProfileOfRequesterState {
  final ProfileEntity profile;

  ProfileOfRequesterSuccess(this.profile);
}
