import 'package:cinestream/data/api/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AuthClient {
  final String _appBaseUrl = 'https://dummyjson.com';

  late Dio _dio;

  AuthClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _appBaseUrl,
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // Add PrettyDioLogger interceptor
    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
          maxWidth: 90,
          enabled: kDebugMode,
        ),
      );
    }

    // Add authorization interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print(options.data);
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401) {
            // Check if the request is login

            return handler.next(error);
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<Response> getData(
    String url, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: query,
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      return Response(statusCode: 1, requestOptions: RequestOptions());
    }
  }

  Future<Response> postData(
    String path, {
    dynamic body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response res = await _dio.post(
      path,
      data: body,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
    return res;
  }
}
