import 'package:petsguides/core/resources/data_state.dart';
import 'package:petsguides/core/usecases/usecase.dart';
import 'package:petsguides/features/map/domain/entities/auto_complete_entity.dart';
import 'package:petsguides/features/map/domain/repository/map_repository.dart';

class MapUseCase
    implements
        UseCase<DataState<List<AutoCompleteEntity>>, Map<String, String>> {
  final MapRepository _mapRepository;
  MapUseCase(this._mapRepository);

  @override
  Future<DataState<List<AutoCompleteEntity>>> call(
      {Map<String, String>? params}) {
    final searchInput = params?['search'];
    return _mapRepository.searchPlaces(searchInput: searchInput ?? "");
  }

  Future<Map<String, dynamic>> getPlace({required Map<String, String> params}) {
    final placeId = params['placeId'] as String;
    return _mapRepository.getPlace(placeId: placeId);
  }

  Future<Map<String, dynamic>> getDirections(
      {required Map<String, String> params}) {
    final origin = params['origin'] as String;
    final destination = params['destination'] as String;

    return _mapRepository.getDirections(
        origin: origin, destination: destination);
  }
}
