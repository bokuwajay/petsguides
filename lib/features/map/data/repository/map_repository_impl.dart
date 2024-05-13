import 'package:petsguides/core/resources/data_state.dart';
import 'package:petsguides/features/map/data/data_sources/map_service.dart';
import 'package:petsguides/features/map/data/models/auto_complete_model.dart';
import 'package:petsguides/features/map/domain/repository/map_repository.dart';

class MapRepositoryImpl implements MapRepository {
  final MapService _mapService;
  MapRepositoryImpl(this._mapService);

  @override
  Future<DataState<List<AutoCompleteModel>>> searchPlaces(
      {required String searchInput}) async {
    try {
      final httpResponse = await _mapService.searchPlaces(searchInput);
      return DataSuccess(httpResponse);
    } on Exception catch (genericException) {
      return GenericDataFailed(genericException);
    }
  }

  @override
  Future<Map<String, dynamic>> getPlace({required String placeId}) async {
    try {
      final httpResponse = await _mapService.getPlace(placeId);
      return httpResponse;
    } on Exception {
      throw Exception().toString();
    }
  }

  @override
  Future<Map<String, dynamic>> getDirections(
      {required String origin, required String destination}) async {
    try {
      final httpResponse = await _mapService.getDirections(origin, destination);
      return httpResponse;
    } on Exception {
      throw Exception().toString();
    }
  }
}
