import 'package:dio/dio.dart';

import 'exception_entity.dart';

ExceptionEntity createExceptionEntity(DioException exception) {
  switch (exception.type) {
    case DioExceptionType.connectionTimeout:
      return ExceptionEntity(
          statusCode: -1,
          exceptionMessage:
              "Connection timed out exception catch in Dio Interceptor");

    case DioExceptionType.sendTimeout:
      return ExceptionEntity(
          statusCode: -1,
          exceptionMessage:
              "Send timed out exception catch in Dio Interceptor");

    case DioExceptionType.receiveTimeout:
      return ExceptionEntity(
          statusCode: -1,
          exceptionMessage:
              "Receive timed out exception catch in Dio Interceptor");

    case DioExceptionType.badCertificate:
      return ExceptionEntity(
          statusCode: -1,
          exceptionMessage:
              "Bad SSL certificates exception catch in Dio Interceptor");

    case DioExceptionType.cancel:
      return ExceptionEntity(
          statusCode: -1,
          exceptionMessage: "Server canceled it catch in Dio Interceptor");

    case DioExceptionType.connectionError:
      return ExceptionEntity(
          statusCode: -1,
          exceptionMessage: "Connection error catch in Dio Interceptor");

    case DioExceptionType.badResponse:
      switch (exception.response!.statusCode) {
        case 400:
          return ExceptionEntity(
              statusCode: 400,
              exceptionMessage:
                  "Bad request: incorrect data type or missing payload catch in Dio Interceptor");
        case 401:
          return ExceptionEntity(
              statusCode: 401,
              exceptionMessage: exception.response!.data['detail']);
        case 500:
          return ExceptionEntity(
              statusCode: 500,
              exceptionMessage:
                  "Server internal error catch in Dio Interceptor");
      }
      return ExceptionEntity(
          statusCode: exception.response!.statusCode!,
          exceptionMessage: "Server bad response");

    case DioExceptionType.unknown:
      return ExceptionEntity(
          statusCode: -1,
          exceptionMessage: "Unknown exception catch in Dio Interceptor");
  }
}
