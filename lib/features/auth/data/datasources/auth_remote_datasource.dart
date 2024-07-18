import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:petsguides/core/api/api_helper.dart';
import 'package:petsguides/core/util/logger.dart';
import 'package:petsguides/features/auth/data/models/auth_model.dart';
import 'package:petsguides/features/auth/domain/usecases/usecase_params.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

sealed class AuthRemoteDataSource {
  Future<AuthModel> authenticate(LoginParams params);
  Future<GoogleSignInAccount?> googleSignIn();
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
    } catch (exception) {
      logger.e('Logger in authenticate of AuthRemoteDataSourceImpl\nrethrow: $exception');
      rethrow;
    }
  }

  @override
  Future<GoogleSignInAccount?> googleSignIn() async {
    try {
      final google = GoogleSignIn(clientId: Platform.isIOS ? dotenv.env['googleLoginIOSClientId'] : null);
      var result = google.signIn();
      return result;
    } catch (exception) {
      logger.e('Logger in googleSignIn of AuthRemoteDataSourceImpl\nrethrow: $exception');
      rethrow;
    }
  }
}
