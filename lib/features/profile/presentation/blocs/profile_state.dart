part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();
}

final class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

final class ProfileLoading extends ProfileState {
  @override
  List<Object> get props => [];
}

final class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object> get props => [message];
}

final class ProfileSuccess extends ProfileState {
  final ProfileEntity profileEntity;

  const ProfileSuccess({
    required this.profileEntity,
  });

  @override
  List<Object> get props => [profileEntity];
}
