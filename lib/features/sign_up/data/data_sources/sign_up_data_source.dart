import 'package:dio/dio.dart';

abstract interface class SignUpDataSource {
  Future<Response> signUp({required Map<String, dynamic> requestBody});
  Future<Response> verifyOTP({required Map<String, dynamic> requestBody});
}
