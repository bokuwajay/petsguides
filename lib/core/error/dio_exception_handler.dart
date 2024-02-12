import 'package:dio/dio.dart';

DioException dioExceptionHandler(DioException dioException) {
  switch (dioException.type) {
    case DioExceptionType.connectionTimeout:
      return DioException(
          requestOptions: dioException.requestOptions,
          message: "Dio Exception Connection Timeout [Dio]",
          type: DioExceptionType.connectionTimeout);

    case DioExceptionType.sendTimeout:
      return DioException(
        requestOptions: dioException.requestOptions,
        message: "Dio Exception Send Timeout [Dio]",
        type: DioExceptionType.sendTimeout,
      );

    case DioExceptionType.receiveTimeout:
      return DioException(
        requestOptions: dioException.requestOptions,
        message: "Dio Exception Receive Timeout [Dio]",
        type: DioExceptionType.receiveTimeout,
      );

    case DioExceptionType.badCertificate:
      return DioException(
        requestOptions: dioException.requestOptions,
        message: "Dio Exception Bad Certificate [Dio]",
        type: DioExceptionType.badCertificate,
      );

    case DioExceptionType.cancel:
      return DioException(
        requestOptions: dioException.requestOptions,
        message: "Dio Exception Cancel [Dio]",
        type: DioExceptionType.cancel,
      );

    case DioExceptionType.connectionError:
      return DioException(
        requestOptions: dioException.requestOptions,
        message: "Connection Error [Dio]",
        type: DioExceptionType.connectionError,
      );

    case DioExceptionType.badResponse:
      switch (dioException.response!.statusCode) {
        case 400:
          return DioException(
            requestOptions: dioException.requestOptions,
            message: dioException.response!.data['detail'],
            type: DioExceptionType.badResponse,
          );
        case 401:
          return DioException(
            requestOptions: dioException.requestOptions,
            message: dioException.response!.data['detail'],
            type: DioExceptionType.badResponse,
          );
        case 403:
          return DioException(
            requestOptions: dioException.requestOptions,
            message: dioException.response!.data['detail'],
            type: DioExceptionType.badResponse,
          );
        case 405:
          return DioException(
            requestOptions: dioException.requestOptions,
            message: dioException.response!.data['detail'],
            type: DioExceptionType.badResponse,
          );
        case 409:
          return DioException(
            requestOptions: dioException.requestOptions,
            message: dioException.response!.data['detail'],
            type: DioExceptionType.badResponse,
          );
        case 500:
          return DioException(
            requestOptions: dioException.requestOptions,
            message: dioException.response!.data['detail'],
            type: DioExceptionType.badResponse,
          );
      }
      return DioException(
        requestOptions: dioException.requestOptions,
        message: dioException.response!.data['detail'],
        type: DioExceptionType.badResponse,
      );

    case DioExceptionType.unknown:
      return DioException(
        requestOptions: dioException.requestOptions,
        message: "Dio Unknown Error [Dio]",
        type: DioExceptionType.unknown,
      );
  }
}
