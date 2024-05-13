import 'package:petsguides/core/resources/data_state.dart';
import 'package:petsguides/features/map/domain/entities/auto_complete_entity.dart';

abstract class MapRepository {
  Future<DataState<List<AutoCompleteEntity>>> searchPlaces(
      {required String searchInput});

  Future<Map<String, dynamic>> getPlace({required String placeId});

  Future<Map<String, dynamic>> getDirections(
      {required String origin, required String destination});
}
