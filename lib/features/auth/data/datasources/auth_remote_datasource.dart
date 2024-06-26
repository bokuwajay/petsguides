import 'package:petsguides/core/api/api_helper.dart';
import 'package:petsguides/core/api/api_url.dart';
import 'package:petsguides/core/constants/error_message.dart';
import 'package:petsguides/core/error/exceptions.dart';
import 'package:petsguides/core/util/logger.dart';
import 'package:petsguides/features/auth/data/models/auth_model.dart';
import 'package:petsguides/features/auth/domain/usecases/usecase_params.dart';

sealed class AuthRemoteDataSource {
  Future<AuthModel> authenticate(LoginParams params);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiHelper apiHelper;

  AuthRemoteDataSourceImpl(this.apiHelper);

  @override
  Future<AuthModel> authenticate(LoginParams params) async {
    try {
      final response = await apiHelper.execute(
        method: Method.post,
        url: '${ApiUrl.baseUrl}/auth/authentication',
        payload: {
          "email": params.email,
          "password": params.password,
        },
      );
      return AuthModel.fromJson(response);
    } catch (exception) {
      logger.e(exception);
      if (exception.toString() == noElement) {
        throw AuthException();
      }
      throw ServerException();
    }
  }
}
