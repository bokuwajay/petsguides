import 'package:fpdart/fpdart.dart';
import 'package:petsguides/core/error/failures.dart';
import 'package:petsguides/features/auth/domain/entities/auth_entity.dart';
import 'package:petsguides/features/auth/domain/usecases/usecase_params.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthEntity>> authenticate(LoginParams params);
  Future<Either<Failure, bool>> checkSignInStatus();
  Future<Either<Failure, bool>> checkFirstLaunch();
  Future<Either<Failure, bool>> firstLaunch();
}
