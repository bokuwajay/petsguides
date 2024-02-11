import 'dart:io';

import 'package:dio/dio.dart';
import 'package:petsguides/core/resources/data_state.dart';
import 'package:petsguides/features/auth/data/data_sources/auth_service.dart';
import 'package:petsguides/features/auth/data/models/auth_model.dart';
import 'package:petsguides/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl(this._authService);

  @override
  Future<DataState<AuthModel>> authenticate({
    required String email,
    required String password,
  }) async {
    try {
      final httpResponse = await _authService.authenticate({
        'email': email,
        'password': password,
      });
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (exception) {
      return DataFailed(exception);
    }
  }
}
