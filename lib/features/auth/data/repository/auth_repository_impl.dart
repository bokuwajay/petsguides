import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:petsguides/core/cache/hive_local_storage.dart';
import 'package:petsguides/core/error/failures.dart';
import 'package:petsguides/core/error/exception_converter.dart';
import 'package:petsguides/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:petsguides/features/auth/data/datasources/auth_remote_datasource.dart';

import 'package:petsguides/features/auth/domain/entities/auth_entity.dart';
import 'package:petsguides/features/auth/domain/repository/auth_repository.dart';
import 'package:petsguides/features/auth/domain/usecases/usecase_params.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;
  final HiveLocalStorage _hiveLocalStorage;

  AuthRepositoryImpl(
    this._authRemoteDataSource,
    this._authLocalDataSource,
    this._hiveLocalStorage,
  );

  @override
  Future<Either<Failure, AuthEntity>> authenticate(LoginParams params) async {
    try {
      final result = await _authRemoteDataSource.authenticate(params);
      await _hiveLocalStorage.save(key: 'pgToken', value: result.data, boxName: 'cache');
      return Right(result);
    } catch (exception) {
      Failure failure = exceptionConverter(exception, 'in authenticate of AuthRepositoryImpl');
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, bool>> checkSignInStatus() async {
    try {
      final result = await _authLocalDataSource.checkSignInStatus();
      return Right(result);
    } catch (exception) {
      Failure failure = exceptionConverter(exception, 'in checkSignInStatus of AuthRepositoryImpl');
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, bool>> checkFirstLaunch() async {
    try {
      final result = await _authLocalDataSource.checkFirstLaunch();
      return Right(result);
    } catch (exception) {
      Failure failure = exceptionConverter(exception, 'in checkFirstLaunch of AuthRepositoryImpl');
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, bool>> firstLaunch() async {
    try {
      final result = await _authLocalDataSource.firstLaunch();
      return Right(result);
    } catch (exception) {
      Failure failure = exceptionConverter(exception, 'in firstLaunch of AuthRepositoryImpl');
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, GoogleSignInAccount?>> googleSignIn() async {
    try {
      final result = await _authRemoteDataSource.googleSignIn();
      return Right(result);
    } catch (exception) {
      Failure failure = exceptionConverter(exception, 'in googleSignIn of AuthRepositoryImpl');
      return Left(failure);
    }
  }
}
