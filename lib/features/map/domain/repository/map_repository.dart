import 'package:fpdart/fpdart.dart';
import 'package:petsguides/core/error/failures.dart';
import 'package:petsguides/core/resources/data_state.dart';
import 'package:petsguides/features/map/domain/entities/auto_complete_entity.dart';
import 'package:petsguides/features/map/domain/usecases/usecase_params.dart';

abstract class MapRepository {
  // Future<DataState<List<AutoCompleteEntity>>> searchPlaces(
  //     {required String searchInput});
  Future<Either<Failure, List<AutoCompleteEntity>>> searchPlaces(
      SearchPlacesParams params);

  // Future<Map<String, dynamic>> getPlace({required String placeId});

  // Future<Map<String, dynamic>> getDirections(
  //     {required String origin, required String destination});

  // Future<Map<String, dynamic>> getPlaceDetails(
  //     {required double lat, required double lng, required int radius});

  // Future<Map<String, dynamic>> getMorePlaceDetails({required String tokenKey});
}
