import 'package:fpdart/fpdart.dart';
import 'package:petsguides/core/error/failures.dart';
import 'package:petsguides/features/map/domain/entities/auto_complete_entity.dart';
import 'package:petsguides/features/map/domain/usecases/usecase_params.dart';

abstract class MapRepository {
  Future<Either<Failure, List<AutoCompleteEntity>>> searchPlaces(
    SearchPlacesParams params,
  );

  Future<Either<Failure, Map<String, dynamic>>> selectFromSearchList(
    SelectFromSearchListParams params,
  );

  Future<Either<Failure, Map<String, dynamic>>> getDirections(
    GetDirectionsParams params,
  );

  Future<Either<Failure, Map<String, dynamic>>> searchInRadius(
    SearchInRadiusParams params,
  );

  Future<Either<Failure, Map<String, dynamic>>> getMorePlacesInRadius(
    GetMorePlacesInRadiusParams params,
  );

  Future<Either<Failure, Map<String, dynamic>>> tapOnCarouselCard(
    TapOnCarouselCardParams params,
  );
}
