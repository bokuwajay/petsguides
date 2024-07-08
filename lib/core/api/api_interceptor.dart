import 'package:dio/dio.dart';
import 'package:petsguides/core/api/api_exception.dart';
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
    logger.e('Catch in Api Interceptor:\nApi Url: $url\nError Type: $errorType');

    switch (err.type) {
      case DioExceptionType.connectionError:
        throw ConnectionErrorException('Catch in Api Interceptor in end-point: $url');
      case DioExceptionType.connectionTimeout:
        throw ConnectionTimeOutException('Catch in Api Interceptor in end-point: $url');
      case DioExceptionType.sendTimeout:
        throw SendTimeOutException('Catch in Api Interceptor in end-point: $url');
      case DioExceptionType.receiveTimeout:
        throw ReceiveTimeOutException('Catch in Api Interceptor in end-point: $url');
      case DioExceptionType.badCertificate:
        throw BadCertificateException('Catch in Api Interceptor in end-point: $url');
      case DioExceptionType.cancel:
        throw CancelException('Catch in Api Interceptor in end-point: $url');
      case DioExceptionType.unknown:
        throw UnknownException('Catch in Api Interceptor in end-point: $url');
      case DioExceptionType.badResponse:
        super.onError(err, handler);
        break;
    }
  }
}
