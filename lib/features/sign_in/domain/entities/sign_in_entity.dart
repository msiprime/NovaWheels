import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String fullName;
  final String? email;
  final String? mobileNumber;
  final String? avatarImage;

  const User({
    required this.id,
    required this.fullName,
    required this.email,
    this.mobileNumber,
    this.avatarImage,
  });

  @override
  List<Object?> get props => [
        id,
        fullName,
        email,
        mobileNumber,
        avatarImage,
      ];
}
