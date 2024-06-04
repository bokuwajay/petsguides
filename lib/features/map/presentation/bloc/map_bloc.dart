import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petsguides/core/resources/data_state.dart';
import 'package:petsguides/features/map/domain/entities/auto_complete_entity.dart';
import 'package:petsguides/features/map/domain/usecases/map_usecase.dart';
import 'package:petsguides/features/map/presentation/bloc/map_event.dart';
import 'package:petsguides/features/map/presentation/bloc/map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final MapUseCase _mapUseCase;

  MapBloc(this._mapUseCase)
      : super(const MapStateUninitialized(isLoading: true)) {
    on<MapEventSearchPlaces>((event, emit) async {
      try {
        final searchInput = event.searchInput;
        final dataState = await _mapUseCase(params: {'search': searchInput});
        if (dataState is DataSuccess<List<AutoCompleteEntity>> &&
            dataState.data!.isNotEmpty) {
          // emit(MapStateSearchPlaces(false, true, dataState.data));
          emit(MapStateWidgetControl(
              false, true, false, false, true, dataState.data));
        } else {
          // emit(const MapStateSearchPlaces(false, true, null));
          emit(const MapStateWidgetControl(
              false, true, false, false, true, null));
        }
      } on Exception catch (genericException) {
        emit(MapStateException(false, genericException));
      }
    });

    on<MapEventCloseResultBoard>(
      (event, emit) async {
        emit(const MapStateSearchPlaces(false, false, null));
      },
    );

    on<MapEventGetPlace>(
      (event, emit) async {
        try {
          final placeId = event.placeId;
          final data = await _mapUseCase.getPlace(params: {'placeId': placeId});
          emit(MapStateGetPlaceSuccess(false, data));
        } on Exception catch (genericException) {
          emit(MapStateException(false, genericException));
        }
      },
    );

    on<MapEventTapOnPlace>(
      (event, emit) async {
        try {
          final placeId = event.placeId;
          final data = await _mapUseCase.getPlace(params: {'placeId': placeId});
          emit(MapStateTapOnPlaceSuccess(false, data));
        } on Exception catch (genericException) {
          emit(MapStateException(false, genericException));
        }
      },
    );

    on<MapEventGetDirections>(
      (event, emit) async {
        try {
          final origin = event.origin;
          final destination = event.destination;
          final data = await _mapUseCase.getDirections(
              params: {'origin': origin, 'destination': destination});
          emit(MapStateGetDirectionsSuccess(false, data));
        } on Exception catch (genericException) {
          emit(MapStateException(false, genericException));
        }
      },
    );

    on<MapEventGetPlaceDetails>((event, emit) async {
      try {
        final tappedPointLng = event.tappedPoint as LatLng;
        final radiusValue = event.radius;
        final data = await _mapUseCase.getPlaceDetails(params: {
          'tappedPointLat': tappedPointLng.latitude,
          'tappedPointLng': tappedPointLng.longitude,
          'radiusValue': radiusValue
        });

        emit(MapStateGetPlaceDetailsSuccess(false, data));
      } on Exception catch (genericException) {
        emit(MapStateException(false, genericException));
      }
    });

    on<MapEventGetMorePlaceDetails>(
      (event, emit) async {
        try {
          final tokenKey = event.tokenKey;
          final data = await _mapUseCase
              .getMorePlaceDetails(params: {'tokenKey': tokenKey});
          emit(MapStateGetMorePlaceDetailsSuccess(false, data));
        } on Exception catch (genericException) {
          emit(MapStateException(false, genericException));
        }
      },
    );

    on<MapEventWidgetControl>(
      (event, emit) {
        final bool showSearchPlacesTextFormField =
            event.showSearchPlacesTextFormField;
        final bool showGetDirection = event.showGetDirection;
        final bool showNearbyPlaces = event.showNearbyPlaces;
        final bool showSearchResultBoard = event.showSearchResultBoard;

        emit(MapStateWidgetControl(false, showSearchPlacesTextFormField,
            showGetDirection, showNearbyPlaces, showSearchResultBoard, null));
      },
    );
  }
}
