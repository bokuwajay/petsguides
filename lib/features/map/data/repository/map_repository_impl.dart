import 'package:fpdart/fpdart.dart';
import 'package:petsguides/core/api/api_exception.dart';
import 'package:petsguides/core/error/exceptions.dart';
import 'package:petsguides/core/error/failures.dart';
import 'package:petsguides/features/map/data/data_sources/map_remote_datasource.dart';
import 'package:petsguides/features/map/domain/entities/auto_complete_entity.dart';
import 'package:petsguides/features/map/domain/repository/map_repository.dart';
import 'package:petsguides/features/map/domain/usecases/usecase_params.dart';

class MapRepositoryImpl implements MapRepository {
  final MapRemoteDataSource _mapRemoteDataSource;

  MapRepositoryImpl(this._mapRemoteDataSource);

  @override
  Future<Either<Failure, List<AutoCompleteEntity>>> searchPlaces(
      SearchPlacesParams params) async {
    try {
      final result = await _mapRemoteDataSource.searchPlaces(params);
      return Right(result);
    } on ApiException {
      return Left(MissingParamsFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> selectFromSearchList(
      SelectFromSearchListParams params) async {
    try {
      final result = await _mapRemoteDataSource.selectFromSearchList(params);
      return Right(result);
    } on ApiException {
      return Left(MissingParamsFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // @override
  // Future<Map<String, dynamic>> getPlace({required String placeId}) async {
  //   try {
  //     final httpResponse = await _mapService.getPlace(placeId);
  //     return httpResponse;
  //   } on Exception {
  //     throw Exception().toString();
  //   }
  // }

  // @override
  // Future<Map<String, dynamic>> getDirections(
  //     {required String origin, required String destination}) async {
  //   try {
  //     final httpResponse = await _mapService.getDirections(origin, destination);
  //     return httpResponse;
  //   } on Exception {
  //     throw Exception().toString();
  //   }
  // }

  // @override
  // Future<Map<String, dynamic>> getPlaceDetails(
  //     {required double lat, required double lng, required int radius}) async {
  //   try {
  //     final httpResponse = await _mapService.getPlaceDetails(lat, lng, radius);
  //     return httpResponse;
  //   } on Exception {
  //     throw Exception().toString();
  //   }
  // }

  // @override
  // Future<Map<String, dynamic>> getMorePlaceDetails(
  //     {required String tokenKey}) async {
  //   try {
  //     final httpResponse = await _mapService.getMorePlaceDetails(tokenKey);
  //     return httpResponse;
  //   } on Exception {
  //     throw Exception().toString();
  //   }
  // }
}
