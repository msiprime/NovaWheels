import 'dart:io' show File;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:nova_wheels/config/environment/build_config.dart';
import 'package:nova_wheels/config/supabase/secret/app_secrets.dart';
import 'package:nova_wheels/shared/local_storage/cache_service.dart';
import 'package:nova_wheels/shared/remote_datasource/exceptions/error_model.dart';
import 'package:nova_wheels/shared/remote_datasource/exceptions/network_exception.dart';
import 'package:nova_wheels/shared/utils/logger.dart';
import 'package:nova_wheels/shared/values/app_strings.dart';

import 'pretty_dio_logger.dart';

class RestClient {
  late Dio _dio;
  final connectionTimeout = 30000;
  final receiveTimeout = 30000;

  RestClient() {
    BaseOptions options = BaseOptions(
      baseUrl: BuildConfig.instance.config.baseUrl,
      headers: <String, dynamic>{
        'apikey': AppSecrets.supaAnonKey,
        'Content-type': 'application/json',
        'Authorization':
            'Bearer ${CacheService.instance.retrieveBearerToken()}',
      },
      connectTimeout: Duration(milliseconds: connectionTimeout),
      receiveTimeout: Duration(milliseconds: receiveTimeout),
    );
    _dio = Dio(options);
  }

  Future<Response<dynamic>> get(
    APIType apiType,
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    _setDioInterceptorList();

    final standardHeaders = await _getOptions(apiType);

    return _dio
        .get(path, queryParameters: data, options: standardHeaders)
        .then((value) => value)
        .catchError(_getDioException);
  }

  Future<Response<dynamic>> post(
    APIType apiType,
    String path,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    _setDioInterceptorList();

    final standardHeaders = await _getOptions(apiType);
    if (headers != null) {
      standardHeaders.headers?.addAll(headers);
    }

    return _dio
        .post(
          path,
          data: data,
          options: standardHeaders,
          queryParameters: queryParams,
        )
        .then((value) => value)
        .catchError(_getDioException);
  }

  /// Supports media upload
  Future<Response<dynamic>> postFormData(
    APIType apiType,
    String path,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    _setDioInterceptorList();

    final standardHeaders = await _getOptions(apiType);
    standardHeaders.headers?.addAll({
      'Content-Type': 'multipart/form-data',
    });

    return _dio
        .post(
          path,
          data: FormData.fromMap(data),
          options: standardHeaders,
          queryParameters: queryParams,
        )
        .then((value) => value)
        .catchError(_getDioException);
  }

  Future<Response<dynamic>> patch(
    APIType api,
    String path,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    _setDioInterceptorList();

    final standardHeaders = await _getOptions(api);
    if (headers != null) {
      standardHeaders.headers?.addAll(headers);
    }

    return _dio
        .patch(
          path,
          data: data,
          options: standardHeaders,
          queryParameters: queryParams,
        )
        .then((value) => value)
        .catchError(_getDioException);
  }

  Future<Response<dynamic>> put(
    APIType apiType,
    String path,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    _setDioInterceptorList();

    final standardHeaders = await _getOptions(apiType);
    if (headers != null) {
      standardHeaders.headers?.addAll(headers);
    }

    return _dio
        .put(
          path,
          data: data,
          options: standardHeaders,
        )
        .then((value) => value)
        .catchError(_getDioException);
  }

  Future<Response<dynamic>> delete(
    APIType apiType,
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    _setDioInterceptorList();

    final standardHeaders = await _getOptions(apiType);
    if (headers != null) {
      standardHeaders.headers?.addAll(headers);
    }

    return _dio
        .delete(
          path,
          data: data,
          queryParameters: queryParams,
          options: standardHeaders,
        )
        .then((value) => value)
        .catchError(_getDioException);
  }

  /// Supports media upload
  Future<Response<dynamic>> putFormData(
    APIType apiType,
    String path,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    _setDioInterceptorList();

    final standardHeaders = await _getOptions(apiType);
    if (headers != null) {
      standardHeaders.headers?.addAll({
        'Content-Type': 'multipart/form-data',
      });
    }
    data.addAll({
      '_method': 'PUT',
    });

    return _dio
        .post(
          path,
          data: FormData.fromMap(data),
          options: standardHeaders,
        )
        .then((value) => value)
        .catchError(_getDioException);
  }

  /// Upload file in s3bucket
  Future<Response> fileUploadInS3Bucket({
    required String preAssignedUrl,
    required File file,
  }) async {
    return _dio.put(
      preAssignedUrl,
      data: file.openRead(),
      options: Options(
        headers: {
          Headers.contentLengthHeader: await file.length(),
        },
      ),
    );
  }

  dynamic _getDioException(error) {
    if (error is DioException) {
      _dioError(error);
    } else {
      throw UnexpectedException(000, 'Something went wrong. Please try again.');
    }
  }

  //ignore: long-method
  void _dioError(DioException error) {
    Log.error(
      'DIO ERROR: ${error.type} ENDPOINT: ${error.requestOptions.baseUrl}${error.requestOptions.path}',
    );
    String endPoint = error.requestOptions.path;

    switch (error.type) {
      case DioExceptionType.cancel:
        throw RequestCancelledException(
          001,
          AppStrings.defaultErrorMessage,
        );
      case DioExceptionType.connectionTimeout:
        throw RequestTimeoutException(ErrorModel(
          message: AppStrings.defaultErrorMessage,
        ));
      case DioExceptionType.unknown:
        throw DefaultException(
          ErrorModel(
            message: AppStrings.defaultErrorMessage,
          ),
        );
      case DioExceptionType.receiveTimeout:
        throw ReceiveTimeoutException(
          004,
          AppStrings.couldNotConnectToServer,
        );
      case DioExceptionType.sendTimeout:
        throw RequestTimeoutException(
          ErrorModel(
            statusCode: 408,
            message: AppStrings.couldNotConnectToServer,
          ),
        );
      case DioExceptionType.badResponse:
        ErrorModel errorModel = ErrorModel.fromJson(error.response!.data);

        _networkException(
          errorModel,
          error.response?.statusCode,
          errorModel.message ?? '',
          endPoint: endPoint,
        );
      case DioExceptionType.badCertificate:
        throw DefaultException(
          ErrorModel(
            statusCode: 500,
            message: AppStrings.defaultErrorMessage,
          ),
        );
      case DioExceptionType.connectionError:
      // TODO: Handle this case.
    }
  }

  void _networkException(
    ErrorModel? errorModel,
    int? statusCode,
    String message, {
    required String endPoint,
  }) {
    switch (statusCode) {
      case 400:
        throw NetworkException(400, errorModel?.message, "");

      case 403:
        throw UnauthorisedException(403, message);
      case 401:
        throw UnauthorisedException(401, message);
      case 404:
        throw NotFoundException(errorModel ?? ErrorModel());
      case 409:
        throw ConflictException(409, message);
      case 500:
        throw InternalServerException(500, message);
      case 502:
        throw BadGatewayException(errorModel ?? ErrorModel());
      default:
        throw DefaultException(
          ErrorModel(
            statusCode: 500,
            message: AppStrings.defaultErrorMessage,
          ),
        );
    }
  }

  void _setDioInterceptorList() {
    List<Interceptor> interceptorList = [];
    _dio.interceptors.clear();

    if (kDebugMode) {
      interceptorList.add(PrettyDioLogger());
    }
    _dio.interceptors.addAll(interceptorList);
  }

  Future<Options> _getOptions(APIType api) async {
    String? token = await CacheService.instance.retrieveBearerToken();
    switch (api) {
      case APIType.public:
        return PublicApiOptions().options;

      case APIType.protected:
        return ProtectedApiOptions(token!).options;

      default:
        return PublicApiOptions().options;
    }
  }
}

abstract class ApiOptions {
  Options options = Options();
}

//public => Generic API url without access token
//protected => Generic API url with access token
enum APIType { public, protected }

class PublicApiOptions extends ApiOptions {
  PublicApiOptions() {
    super.options.headers = <String, dynamic>{
      'Accept': 'application/json',
      'Content-type': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
  }
}

class ProtectedApiOptions extends ApiOptions {
  ProtectedApiOptions(String apiToken) {
    super.options.headers = <String, dynamic>{
      'Accept': 'application/json',
      'Content-type': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $apiToken',
    };
  }
}
