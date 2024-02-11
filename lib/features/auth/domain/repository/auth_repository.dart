import 'package:petsguides/core/resources/data_state.dart';
import 'package:petsguides/features/auth/domain/entities/auth_entity.dart';

abstract class AuthRepository {
  Future<DataState<AuthEntity>> authenticate({
    required String email,
    required String password,
  });
}
