import 'package:equatable/equatable.dart';

enum LandingStatus { initial, navigate }

class LandingState extends Equatable {
  final LandingStatus landingStatus;
  final String? bearerToken;
  final bool? isFirstTimer;

  const LandingState({
    required this.landingStatus,
    this.bearerToken,
    this.isFirstTimer,
  });

  LandingState copyWith({
    required LandingStatus? landingStatus,
    String? token,
    String? fcmToken,
    bool? isFirstTimer,
  }) {
    return LandingState(
      landingStatus: landingStatus ?? this.landingStatus,
      bearerToken: token ?? bearerToken,
      isFirstTimer: isFirstTimer ?? this.isFirstTimer,
    );
  }

  @override
  List<Object?> get props => [
        landingStatus,
        bearerToken,
        isFirstTimer,
      ];
}
