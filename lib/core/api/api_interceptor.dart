import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:petsguides/core/cache/hive_local_storage.dart';
import 'package:petsguides/core/util/logger.dart';
import 'package:petsguides/injection_container.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'api_url.dart';

class ApiInterceptor extends Interceptor {
  final List<String> externalBaseUrls = [dotenv.env['googleMapBaseUrl']!.toString()];

  final List<String> publicEndpoints = ['/auth/authentication'];

  bool isExternalBaseUrl(String baseUrl) {
    return externalBaseUrls.any((url) => baseUrl.startsWith(url));
  }

  bool isPublicEndpoint(String path) {
    return publicEndpoints.any((endpoint) => path.startsWith(endpoint));
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.baseUrl.isEmpty) {
      options.baseUrl = ApiUrl.baseUrl;
    }

    if (!isExternalBaseUrl(options.baseUrl) && !isPublicEndpoint(options.path)) {
      final token = await sl<HiveLocalStorage>().load(key: 'pgToken', boxName: 'cache');
      if (token == null ||
          JwtDecoder.decode(token)['exp'] == null ||
          DateTime.fromMillisecondsSinceEpoch(JwtDecoder.decode(token)['exp'] * 1000).isBefore(DateTime.now())) {
        return handler.reject(
          DioException(
            requestOptions: options,
            type: DioExceptionType.badResponse,
            response: Response(
              requestOptions: options,
              statusCode: 401,
              statusMessage: 'Unauthorized',
            ),
          ),
        );
      }
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // here {err.response} is as the same as {dioException.response} in ApiHelper
    // but we catch dio exception that has no statusCode here first (we differentiate by dioException type)
    // we catch dioException that has statusCode in ApiHelper
    String url = err.requestOptions.uri.toString();
    String errorType = err.type.toString();
    logger.e('Logger in Api Interceptor:\nApi Url: $url\nError Type: $errorType');
    super.onError(err, handler);
  }
}
