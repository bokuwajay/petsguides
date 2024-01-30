import 'package:dio/dio.dart';
import 'package:petsguides/services/auth/auth_exceptions.dart';
import 'package:petsguides/services/dio/dio_interceptor.dart';
import 'package:petsguides/services/dio/exception_entity.dart';
// import 'dart:developer' as devtools show log;

class AuthService {
  final HttpUtil httpUtil;

  AuthService(this.httpUtil);

  Future<void> register(String firstName, String lastName, String email,
      String password, String phone) async {
    try {
      await httpUtil.post(
        '/auth/registration',
        data: {
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'password': password,
          'phone': phone,
        },
      );
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<Map?> authenticate(String email, String password) async {
    try {
      final response = await httpUtil.post(
        '/auth/authentication',
        data: {
          'email': email,
          'password': password,
        },
      );
      return response;
    } on DioException catch (exception) {
      if (exception.error is ExceptionEntity) {
        final exceptionEntity = exception.error as ExceptionEntity;
        throw UserNotFoundAuthException(
            exceptionMessage: exceptionEntity.exceptionMessage);
      }
    }
    return null;
  }
}
