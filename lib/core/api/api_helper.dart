import 'dart:io';

import 'package:dio/dio.dart';
import 'package:petsguides/core/error/exceptions.dart';

enum Method { get, post, put, patch, delete }

class ApiHelper {
  final Dio _dio;
  const ApiHelper(this._dio);

  Future<Map<String, dynamic>> execute({
    required Method method,
    String? baseUrl,
    required String endpoint,
    dynamic payload,
  }) async {
    try {
      if (baseUrl != null) {
        _dio.options.baseUrl = baseUrl;
      }
      Response? response;
      switch (method) {
        case Method.get:
          // Each request will first go into Api Interceptor onRequest and onError, then go below
          response = await _dio.get(endpoint);
          break;
        case Method.post:
          response = await _dio.post(endpoint, data: payload);
          break;
        case Method.put:
          response = await _dio.put(endpoint);
          break;
        case Method.patch:
          response = await _dio.patch(endpoint);
          break;
        case Method.delete:
          response = await _dio.delete(endpoint);
          break;
      }

      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException;
    } on DioException catch (dioException) {
      switch (dioException.type) {
        case DioExceptionType.connectionError:
          throw ConnectionErrorException;
        case DioExceptionType.connectionTimeout:
          throw ConnectionTimeOutException;
        case DioExceptionType.sendTimeout:
          throw SendTimeOutException;
        case DioExceptionType.receiveTimeout:
          throw ReceiveTimeOutException;
        case DioExceptionType.badCertificate:
          throw BadCertificateException;
        case DioExceptionType.cancel:
          throw CancelException;
        case DioExceptionType.unknown:
          throw UnknownException;
        case DioExceptionType.badResponse:
          return _returnResponse(dioException.response!);
      }
    }
  }

  Map<String, dynamic> _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 201:
        return response.data;
      case 400:
        throw BadRequestException;
      case 401:
        throw UnauthorizedException;
      case 403:
        throw ForbiddenException;
      case 404:
        throw NotFoundException;
      case 405:
        throw MethodNotAllowedException;
      case 409:
        throw DuplicatedDataException;
      case 422:
        throw UnprocessableContentException;
      case 500:
        throw InternalServerException;
      default:
        throw UnknownException;
    }
  }
}
