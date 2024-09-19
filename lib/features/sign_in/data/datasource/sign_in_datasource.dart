import 'package:nova_wheels/features/sign_in/data/model/sign_in_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class SignInDataSource {
  Session? get currentSessionKey;

  Future<UserModel?> getCurrentUserData();

  Future<String> signIn({
    required String email,
    required String password,
  });

  Future<AuthResponse> googleSignIn();

  Future<void> signOut();

  Future<void> requestOtpForForgetPassword({
    required Map<String, dynamic> requestBody,
  });

  Future<UserResponse> resetPassword({
    required Map<String, dynamic> requestBody,
  });

  Future<AuthResponse> verifyOTP({required Map<String, dynamic> requestBody});
}
