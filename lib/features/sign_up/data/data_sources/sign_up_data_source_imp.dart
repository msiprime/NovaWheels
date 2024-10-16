import 'package:nova_wheels/core/base_component/failure/exceptions.dart';
import 'package:nova_wheels/shared/utils/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'sign_up_data_source.dart';

class SignUpDataSourceImp implements SignUpDataSource {
  const SignUpDataSourceImp({
    required this.supabaseClient,
  });

  final SupabaseClient supabaseClient;

  @override
  Future<AuthResponse> signUp(
      {required Map<String, dynamic> requestBody}) async {
    final response = await supabaseClient.auth.signUp(
      email: requestBody['email'],
      password: requestBody['password'],
      data: {
        'full_name': requestBody['full_name'],
        'email': requestBody['email'],
        'phone_number': requestBody['phone_number'],
      },
    );

    Log.debug(response.toString());

    return response;
  }

  @override
  Future<AuthResponse> verifyOTP({
    required Map<String, dynamic> requestBody,
  }) async {
    final response = await supabaseClient.auth.verifyOTP(
      type: OtpType.signup,
      token: requestBody['otp'],
      email: requestBody['email'],
    );
    return response;
  }

  @override
  Future<ResendResponse> resendOTP({
    required String email,
  }) async {
    try {
      final res = await supabaseClient.auth.resend(
        type: OtpType.signup,
        email: email,
      );
      return res;
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }
}
