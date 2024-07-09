import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:petsguides/core/error/failures.dart';
import 'package:petsguides/core/usecases/usecase.dart';
import 'package:petsguides/features/auth/domain/entities/auth_entity.dart';
import 'package:petsguides/features/auth/domain/repository/auth_repository.dart';

class Params extends Equatable {
  final String email;
  final String password;
  const Params({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}

class AuthUseCase implements UseCase<AuthEntity, Params> {
  final AuthRepository _authRepository;
  AuthUseCase(this._authRepository);

  @override
  Future<Either<Failure, AuthEntity>> call(Params params) async {
    if (params.email.isEmpty || params.password.isEmpty) {
      Failure failure = const MissingParamsFailure(suffix: 'in call of AuthUseCase');
      return Left(failure);
    }
    final result = await _authRepository.authenticate(params);
    return result;
  }
}
