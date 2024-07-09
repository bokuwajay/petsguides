import 'package:petsguides/core/api/api_helper.dart';
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
      final result = await apiHelper.execute(
        method: Method.post,
        endpoint: '/auth/authentication',
        payload: {
          "email": params.email,
          "password": params.password,
        },
      );
      return AuthModel.fromJson(result);
    } on Exception catch (exception) {
      logger.e('Logger in authenticate of AuthRemoteDataSourceImpl\nrethrow: $exception');
      rethrow;
    }
  }
}
