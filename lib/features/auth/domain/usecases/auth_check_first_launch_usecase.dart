import 'package:fpdart/fpdart.dart';
import 'package:petsguides/core/error/failures.dart';
import 'package:petsguides/core/usecases/usecase.dart';
import 'package:petsguides/features/auth/domain/repository/auth_repository.dart';

class AuthCheckFirstLaunchUseCase implements UseCase<bool, NoParams> {
  final AuthRepository _authRepository;
  const AuthCheckFirstLaunchUseCase(this._authRepository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await _authRepository.checkFirstLaunch();
  }
}
