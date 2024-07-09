import 'package:dio/dio.dart';
import 'package:petsguides/core/util/logger.dart';

import 'api_url.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.baseUrl.isEmpty) {
      options.baseUrl = ApiUrl.baseUrl;
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // here {err.response} is as the same as {dioException.response} in ApiHelper
    // but we catch dio exception that has no statusCode here first (we differentiate by dioException type here)
    // we catch dioException that has statusCode in ApiHelper
    String url = err.requestOptions.uri.toString();
    String errorType = err.type.toString();
    logger.e('Logger in Api Interceptor:\nApi Url: $url\nError Type: $errorType');
    super.onError(err, handler);
  }
}
