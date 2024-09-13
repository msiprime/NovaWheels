// import 'dart:convert';
// import 'dart:typed_data';
//
// import 'package:dio/dio.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
//
// class ApiCachingInterceptor extends Interceptor {
//   static final ApiCachingInterceptor _singleton =
//       ApiCachingInterceptor._internal();
//   final CacheManager _cacheManager = DefaultCacheManager();
//   final Duration _staleTime = const Duration(seconds: 15);
//
//   factory ApiCachingInterceptor() {
//     return _singleton;
//   }
//
//   ApiCachingInterceptor._internal() {
//     _cacheManager.emptyCache();
//   }
//
//   @override
//   Future onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     if (!options.extra.containsKey('skipCache')) {
//       final cacheKey = options.uri.toString();
//       final fileInfo = await _cacheManager.getFileFromCache(cacheKey);
//       if (fileInfo != null) {
//         final lastModified = fileInfo.validTill;
//         if (DateTime.now().difference(lastModified) <= _staleTime) {
//           final cachedData = await _cacheManager.getFileFromCache(cacheKey,
//               ignoreMemCache: true);
//           if (cachedData != null) {
//             final cachedResponse = Response<dynamic>(
//               requestOptions: options,
//               statusCode: 200,
//               data: json.decode(cachedData.file.readAsStringSync()),
//             );
//             handler.resolve(cachedResponse);
//
//             if (DateTime.now().difference(lastModified) > _staleTime) {
//               _performBackgroundAPICall(options.uri);
//             }
//             return;
//           }
//         }
//       }
//     }
//     handler.next(options);
//   }
//
//   Future<void> _performBackgroundAPICall(Uri uri) async {
//     await Future.delayed(const Duration(seconds: 1));
//   }
//
//   @override
//   Future onResponse(
//       Response response, ResponseInterceptorHandler handler) async {
//     final cacheKey = response.requestOptions.uri.toString();
//     final jsonData = json.encode(response.data);
//     final uint8List = Uint8List.fromList(utf8.encode(jsonData));
//
//     await _cacheManager.putFile(cacheKey, uint8List);
//     handler.next(response);
//   }
// }
