import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsguides/core/resources/data_state.dart';
import 'package:petsguides/features/map/domain/usecases/map_usecase.dart';
import 'package:petsguides/features/map/presentation/bloc/map_event.dart';
import 'package:petsguides/features/map/presentation/bloc/map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final MapUseCase _mapUseCase;

  MapBloc(this._mapUseCase)
      : super(const MapStateUninitialized(
            isLoading: true, searchResultBoard: false)) {
    on<MapEventSearchPlaces>((event, emit) async {
      final searchInput = event.searchInput;

      final dataState = await _mapUseCase(params: {'search': searchInput});

      if (dataState is DataSuccess) {
        emit(MapStateSearchPlacesSuccess(
          autoComplete: dataState.data,
          isLoading: false,
          searchResultBoard: true,
        ));
      } else if (dataState is GenericDataFailed) {
        emit(MapStateSearchPlacesFail(
            genericException: dataState.genericException,
            isLoading: false,
            searchResultBoard: true));
      }
    });

    on<MapEventCloseResultBoard>(
      (event, emit) async {
        emit(MapStateSearchToggle(isLoading: false, searchResultBoard: false));
      },
    );

    on<MapEventGetPlace>(
      (event, emit) async {
        final placeId = event.placeId;
        final data = await _mapUseCase.getPlace(params: {'placeId': placeId});

        emit(MapStateGetPlaceSuccess(
            isLoading: false, searchResultBoard: false, getPlaceResult: data));
      },
    );
  }
}
