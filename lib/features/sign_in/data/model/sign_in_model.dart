import 'package:quick_start/features/sign_in/domain/entities/sign_in_entity.dart';

class SignInModel extends SignInEntity {
  SignInModel({
    required super.token,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
        token: json['token'],
      );
}
