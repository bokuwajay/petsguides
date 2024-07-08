import 'dart:io';

import 'package:dio/dio.dart';

import 'api_exception.dart';

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
      throw FetchDataException('No Internet Connection');
    } on DioException catch (dioException) {
      return _returnResponse(dioException.response!);
    }
  }

  Map<String, dynamic> _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 201:
        return response.data;
      case 400:
        throw BadRequestException(response.data["message"].toString());
      case 401:
        throw UnauthorizedException(response.data["message"].toString());
      case 403:
        throw ForbiddenException(response.data["message"].toString());
      case 404:
        throw NotFoundException(response.data["message"].toString());
      case 405:
        throw MethodNotAllowedException(response.data["message"].toString());
      case 409:
        throw DuplicatedDataException(response.data["message"].toString());
      case 422:
        throw UnprocessableContentException(response.data["message"].toString());
      case 500:
        throw InternalServerException(response.data["message"].toString());
      default:
        throw FetchDataException('Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
