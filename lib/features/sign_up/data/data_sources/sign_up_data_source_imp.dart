import 'package:dio/dio.dart';
import 'package:nova_wheels/shared/remote_datasource/network/api_end_points.dart';
import 'package:nova_wheels/shared/remote_datasource/network/rest_client.dart';

import 'sign_up_data_source.dart';

class SignUpDataSourceImp implements SignUpDataSource {
  const SignUpDataSourceImp({required this.restClient});

  final RestClient restClient;

  @override
  Future<Response> signUp({required Map<String, dynamic> requestBody}) async {
    final response = await restClient.post(
      APIType.public,
      ApiEndPoints.signUp,
      requestBody,
    );

    return response;
  }

  @override
  Future<Response> verifyOTP(
      {required Map<String, dynamic> requestBody}) async {
    final response = await restClient.post(
      APIType.public,
      ApiEndPoints.verifyOtp,
      requestBody,
    );

    return response;
  }
}
