import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:petsguides/core/error/failures.dart';
import 'package:petsguides/core/usecases/usecase.dart';
import 'package:petsguides/features/auth/domain/repository/auth_repository.dart';

class AuthGoogleSignInUseCase implements UseCase<GoogleSignInAccount?, NoParams> {
  final AuthRepository _authRepository;
  const AuthGoogleSignInUseCase(this._authRepository);

  @override
  Future<Either<Failure, GoogleSignInAccount?>> call(NoParams params) async {
    return await _authRepository.googleSignIn();
  }
}
