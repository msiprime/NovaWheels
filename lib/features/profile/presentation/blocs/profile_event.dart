part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class GetProfileDataEvent extends ProfileEvent {
  const GetProfileDataEvent();

  @override
  List<Object> get props => [];
}

class UpdateProfileDataEvent extends ProfileEvent {
  final String? fullName;
  final String? userName;
  final String? email;
  final String? mobileNumber;
  final String? website;
  final String? avatarUrl;

  const UpdateProfileDataEvent({
    required this.fullName,
    required this.userName,
    required this.email,
    required this.mobileNumber,
    required this.website,
    required this.avatarUrl,
  });

  @override
  List<Object> get props => [];
}
