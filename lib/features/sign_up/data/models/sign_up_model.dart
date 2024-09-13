import 'package:nova_wheels/features/sign_up/domain/entities/sign_up_entity.dart';

class SignUpModel extends SignUpEntity {
  SignUpModel({
    required super.message,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        message: json.values.first.toString(),
      );
}
