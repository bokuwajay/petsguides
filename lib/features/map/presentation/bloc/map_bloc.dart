import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

    on<MapEventTapOnPlace>(
      (event, emit) async {
        final placeId = event.placeId;
        final data = await _mapUseCase.getPlace(params: {'placeId': placeId});

        emit(MapStateTapOnPlaceSuccess(
            isLoading: false,
            searchResultBoard: false,
            tapOnPlaceResult: data));
      },
    );

    on<MapEventGetDirections>(
      (event, emit) async {
        final origin = event.origin;
        final destination = event.destination;

        final data = await _mapUseCase.getDirections(
            params: {'origin': origin, 'destination': destination});

        emit(MapStateGetDirectionsSuccess(
            isLoading: false, getDirections: data, searchResultBoard: false));
      },
    );

    on<MapEventGetPlaceDetails>((event, emit) async {
      final tappedPointLng = event.tappedPoint as LatLng;
      final radiusValue = event.radius;

      final data = await _mapUseCase.getPlaceDetails(params: {
        'tappedPointLat': tappedPointLng.latitude,
        'tappedPointLng': tappedPointLng.longitude,
        'radiusValue': radiusValue
      });
      emit(MapStateGetPlaceDetailsSuccess(
          isLoading: false, getPlaceDetails: data, searchResultBoard: false));
    });

    on<MapEventGetMorePlaceDetails>(
      (event, emit) async {
        final tokenKey = event.tokenKey;

        final data = await _mapUseCase
            .getMorePlaceDetails(params: {'tokenKey': tokenKey});
        emit(MapStateGetMorePlaceDetailsSuccess(
            isLoading: false,
            getMorePlaceDetails: data,
            searchResultBoard: false));
      },
    );
  }
}
