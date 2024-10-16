import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class SignUpDataSource {
  Future<AuthResponse> signUp({required Map<String, dynamic> requestBody});

  Future<AuthResponse> verifyOTP({required Map<String, dynamic> requestBody});

  Future<ResendResponse> resendOTP({required String email});
}
