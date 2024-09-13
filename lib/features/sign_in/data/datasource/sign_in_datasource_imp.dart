import 'package:dio/dio.dart';
import 'package:quick_start/shared/remote_datasource/network/api_end_points.dart';
import 'package:quick_start/shared/remote_datasource/network/rest_client.dart';

import 'sign_in_datasource.dart';

class SignInDataSourceImp implements SignInDataSource {
  const SignInDataSourceImp({required this.restClient});

  final RestClient restClient;

  @override
  Future<Response> signIn({required Map<String, dynamic> requestBody}) async {
    final response = await restClient.post(
      APIType.public,
      ApiEndPoints.signIn,
      requestBody,
    );

    return response;
  }
}
