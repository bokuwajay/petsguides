import 'package:fpdart/fpdart.dart';
import 'package:petsguides/core/error/failures.dart';
import 'package:petsguides/core/error/exception_converter.dart';
import 'package:petsguides/features/map/data/data_sources/map_remote_datasource.dart';
import 'package:petsguides/features/map/domain/entities/auto_complete_entity.dart';
import 'package:petsguides/features/map/domain/repository/map_repository.dart';
import 'package:petsguides/features/map/domain/usecases/usecase_params.dart';

class MapRepositoryImpl implements MapRepository {
  final MapRemoteDataSource _mapRemoteDataSource;

  MapRepositoryImpl(this._mapRemoteDataSource);

  @override
  Future<Either<Failure, List<AutoCompleteEntity>>> searchPlaces(SearchPlacesParams params) async {
    try {
      final result = await _mapRemoteDataSource.searchPlaces(params);
      return Right(result);
    } catch (exception) {
      Failure failure = exceptionConverter(exception, 'in searchPlaces of MapRepositoryImpl');
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> selectFromSearchList(SelectFromSearchListParams params) async {
    try {
      final result = await _mapRemoteDataSource.selectFromSearchList(params);
      return Right(result);
    } catch (exception) {
      Failure failure = exceptionConverter(exception, 'in selectFromSearchList of MapRepositoryImpl');
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getDirections(GetDirectionsParams params) async {
    try {
      final result = await _mapRemoteDataSource.getDirections(params);
      return Right(result);
    } catch (exception) {
      Failure failure = exceptionConverter(exception, 'in getDirections of MapRepositoryImpl');
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> searchInRadius(SearchInRadiusParams params) async {
    try {
      final result = await _mapRemoteDataSource.searchInRadius(params);
      return Right(result);
    } catch (exception) {
      Failure failure = exceptionConverter(exception, 'in searchInRadius of MapRepositoryImpl');
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getMorePlacesInRadius(GetMorePlacesInRadiusParams params) async {
    try {
      final result = await _mapRemoteDataSource.getMorePlacesInRadius(params);
      return Right(result);
    } catch (exception) {
      Failure failure = exceptionConverter(exception, 'in getMorePlacesInRadius of MapRepositoryImpl');
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> tapOnCarouselCard(TapOnCarouselCardParams params) async {
    try {
      final result = await _mapRemoteDataSource.tapOnCarouselCard(params);
      return Right(result);
    } catch (exception) {
      Failure failure = exceptionConverter(exception, 'in tapOnCarouselCard of MapRepositoryImpl');
      return Left(failure);
    }
  }
}
