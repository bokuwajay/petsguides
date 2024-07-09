import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:petsguides/core/cache/hive_local_storage.dart';
import 'package:petsguides/core/error/exceptions.dart';
import 'package:petsguides/core/error/failures.dart';
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
      if (result.statusCode == HttpStatus.ok) {
        await _hiveLocalStorage.save(
          key: 'pgToken',
          value: result.data,
          boxName: 'cache',
        );
        return Right(result);
      }
      return const Left(CredentialFailure('in authenticate of AuthRepositoryImpl'));
    } on Exception catch (exception) {
      throw exception;
    }

    // on ApiException {
    //   return const Left(CredentialFailure('in authenticate of AuthRepositoryImpl'));
    // } on ServerException {
    //   return const Left(ServerFailure('in authenticate of AuthRepositoryImpl'));
    // }
  }

  @override
  Future<Either<Failure, bool>> checkSignInStatus() async {
    try {
      final result = await _authLocalDataSource.checkSignInStatus();
      return Right(result);
    } on CacheException {
      return const Left(CacheFailure('in checkSignInStatus of AuthRepositoryImpl'));
    }
  }

  @override
  Future<Either<Failure, bool>> firstLaunch() async {
    try {
      await _hiveLocalStorage.save(
        key: 'FIRST_LAUNCH',
        value: 'pets_guides',
        boxName: 'cache',
      );
      return const Right(true);
    } on CacheException {
      return const Left(CacheFailure('in firstLaunch of AuthRepositoryImpl'));
    }
  }

  @override
  Future<Either<Failure, bool>> checkFirstLaunch() async {
    try {
      final result = await _authLocalDataSource.checkFirstLaunch();
      return Right(result);
    } on CacheException {
      return const Left(CacheFailure('in checkFirstLaunch of AuthRepositoryImpl'));
    }
  }
}
