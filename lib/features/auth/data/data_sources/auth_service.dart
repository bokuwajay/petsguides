import 'package:dio/dio.dart';
import 'package:petsguides/core/constants/constants.dart';
import 'package:petsguides/features/auth/data/models/auth_model.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_service.g.dart';

@RestApi(baseUrl: baseURL)
abstract class AuthService {
  factory AuthService(Dio dio) = _AuthService;

  @POST('/auth/authentication')
  Future<HttpResponse<AuthModel>> authenticate(
    @Body() Map<String, dynamic> body,
  );
}
