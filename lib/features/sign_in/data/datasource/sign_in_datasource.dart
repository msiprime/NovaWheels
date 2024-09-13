import 'package:dio/dio.dart';

abstract interface class SignInDataSource {
  Future<Response> signIn({required Map<String, dynamic> requestBody});
}
