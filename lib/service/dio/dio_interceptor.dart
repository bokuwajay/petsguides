import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import 'create_excpetion_entiry.dart';
import 'exception_entity.dart';

class HttpUtil {
  late Dio dio;

  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() {
    return _instance;
  }

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: "http://10.8.9.152:4000/api/v1",
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {},
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    );

    dio = Dio(options);

    // bypasses SSL certificate validation, allowing connections to servers with invalid or self-signed certificates.
    // often used during development or for testing purposes
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        // Don't trust any certificate just because their root cert is trusted.
        final HttpClient client =
            HttpClient(context: SecurityContext(withTrustedRoots: false));
        // You can test the intermediate / root cert here. We just ignore it.
        client.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return client;
      },
    );

    dio.interceptors.add(InterceptorsWrapper(onRequest: (
      options,
      handler,
    ) {
      return handler.next(options);
    }, onResponse: (
      response,
      handler,
    ) {
      if (kDebugMode) {
        print("app response data ${response.data}");
      }
      return handler.next(response);
    }, onError: (
      DioException exception,
      handler,
    ) {
      if (kDebugMode) {
        print("app error data $exception");
      }
      // this is for customized the error message, but on further action
      ExceptionEntity eInfo = createExceptionEntity(exception);

      // therefore we need this one, not just return the error message, this one based on the status code from ExceptionEntity
      // to customized further action inside this method
      onError(eInfo);
    }));
  }

  Map<String, dynamic>? getAuthorizationHeader() {
    var headers = <String, dynamic>{};
    // if (Get.isRegistered<UserStore>() && UserStore.to.hasToken == true) {
    //   headers['Authorization'] = 'Bearer ${UserStore.to.token}';
    // }
    return headers;
  }

  Future get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    var response = await dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
    return response.data;
  }

  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();

    if (!path.startsWith('/auth/')) {
      requestOptions.headers = requestOptions.headers ?? {};
      Map<String, dynamic>? authorization = getAuthorizationHeader();

      if (authorization != null) {
        requestOptions.headers!.addAll(authorization);
      }
    }
    var response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
    );
    return response.data;
  }

  void onError(ExceptionEntity eInfo) {
    print(
        'error.code -> ${eInfo..statusCode}, error.message -> ${eInfo.exceptionMessage}');
    switch (eInfo.statusCode) {
      case 400:
        print("Server syntax error");
        break;
      case 401:
        print("You are denied to continue");
        // we can navigate to login screen  /  get the re flash token to send the request again
        break;
      case 500:
        print("Server internal error");
        break;
      default:
        print("Unknown error");
        break;
    }
  }
}
