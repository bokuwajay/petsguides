import 'package:petsguides/core/resources/data_state.dart';
import 'package:petsguides/core/usecases/usecase.dart';
import 'package:petsguides/features/auth/domain/entities/auth_entity.dart';
import 'package:petsguides/features/auth/domain/repository/auth_repository.dart';

class AuthUseCase
    implements UseCase<DataState<AuthEntity>, Map<String, String>> {
  final AuthRepository _authRepository;
  AuthUseCase(this._authRepository);

  @override
  Future<DataState<AuthEntity>> call({Map<String, String>? params}) {
    final email = params?['email'];
    final password = params?['password'];
    return _authRepository.authenticate(
      email: email ?? "",
      password: password ?? "",
    );
  }
}
