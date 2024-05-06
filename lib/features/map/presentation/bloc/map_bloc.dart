import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsguides/core/resources/data_state.dart';
import 'package:petsguides/features/map/domain/usecases/map_usecase.dart';
import 'package:petsguides/features/map/presentation/bloc/map_event.dart';
import 'package:petsguides/features/map/presentation/bloc/map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final MapUseCase _mapUseCase;

  MapBloc(this._mapUseCase)
      : super(const MapStateUninitialized(isLoading: true)) {
    on<MapEventSearchPlaces>((event, emit) async {
      emit(const MapStateSearching(isLoading: true));
      final searchInput = event.searchInput;

      final dataState = await _mapUseCase(params: {'search': searchInput});
      print(dataState);
      if (dataState is DataSuccess) {
        emit(MapStateSearchPlacesSuccess(
            autoComplete: dataState.data, isLoading: false));
      } else if (dataState is GenericDataFailed) {
        emit(MapStateSearchPlacesFail(
            genericException: dataState.genericException, isLoading: false));
      }
    });
  }
}
