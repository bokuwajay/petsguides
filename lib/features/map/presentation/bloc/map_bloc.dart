import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petsguides/core/resources/data_state.dart';
import 'package:petsguides/core/util/failure_converter.dart';
import 'package:petsguides/features/map/domain/entities/auto_complete_entity.dart';
import 'package:petsguides/features/map/domain/usecases/map_search_places_usecase.dart';
import 'package:petsguides/features/map/domain/usecases/map_usecase.dart';
import 'package:petsguides/features/map/domain/usecases/usecase_params.dart';
import 'package:petsguides/features/map/presentation/bloc/map_event.dart';
import 'package:petsguides/features/map/presentation/bloc/map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final MapSearchPlacesUseCase _mapSearchPlacesUseCase;

  MapBloc(this._mapSearchPlacesUseCase) : super(MapStateInitial()) {
    on<MapEventSearchPlaces>((event, emit) async {
      emit(MapStateLoading());

      final result = await _mapSearchPlacesUseCase
          .call(SearchPlacesParams(searchInput: event.searchInput));
      result.fold((l) => emit(MapStateSearchPlacesFailed(failureConverter(l))),
          (r) => emit(MapStateSearchPlacesSuccessful(r)));
    });

    // on<MapEventSelectFromSearchList>(
    //   (event, emit) async {
    //     try {
    //       final placeId = event.placeId;
    //       final data = await _mapUseCase.getPlace(params: {'placeId': placeId});
    //       emit(MapStateSelectFromListSuccess(false, data));
    //     } on Exception catch (genericException) {
    //       emit(MapStateException(false, genericException));
    //     }
    //   },
    // );

    // on<MapEventTapOnCarouselCard>(
    //   (event, emit) async {
    //     try {
    //       final placeId = event.placeId;
    //       final data = await _mapUseCase.getPlace(params: {'placeId': placeId});
    //       emit(MapStatePlacesDetailCardsWidgetControl(
    //           false, null, true, true, data));
    //     } on Exception catch (genericException) {
    //       emit(MapStateException(false, genericException));
    //     }
    //   },
    // );

    // on<MapEventGetDirections>(
    //   (event, emit) async {
    //     try {
    //       final origin = event.origin;
    //       final destination = event.destination;
    //       final data = await _mapUseCase.getDirections(
    //           params: {'origin': origin, 'destination': destination});
    //       emit(MapStateGetDirectionsSuccess(false, data));
    //     } on Exception catch (genericException) {
    //       emit(MapStateException(false, genericException));
    //     }
    //   },
    // );

    // on<MapEventGetPlaceDetails>((event, emit) async {
    //   try {
    //     final tappedPointLng = event.tappedPoint as LatLng;
    //     final radiusValue = event.radius;
    //     final data = await _mapUseCase.getPlaceDetails(params: {
    //       'tappedPointLat': tappedPointLng.latitude,
    //       'tappedPointLng': tappedPointLng.longitude,
    //       'radiusValue': radiusValue
    //     });

    //     emit(MapStatePlacesDetailCardsWidgetControl(
    //         false, data, true, false, null));
    //   } on Exception catch (genericException) {
    //     emit(MapStateException(false, genericException));
    //   }
    // });

    // on<MapEventGetMorePlaceDetails>(
    //   (event, emit) async {
    //     try {
    //       final tokenKey = event.tokenKey;
    //       final data = await _mapUseCase
    //           .getMorePlaceDetails(params: {'tokenKey': tokenKey});
    //       emit(MapStateGetMorePlaceDetailsSuccess(false, data));
    //     } on Exception catch (genericException) {
    //       emit(MapStateException(false, genericException));
    //     }
    //   },
    // );

    // on<MapEventSearchWidgetControl>(
    //   (event, emit) {
    //     final bool showSearchPlacesTextFormField =
    //         event.showSearchPlacesTextFormField;
    //     final bool showGetDirection = event.showGetDirection;
    //     final bool showSearchResultBoard = event.showSearchResultBoard;

    //     emit(MapStateSearchPlacesSuccessful(
    //       showSearchPlacesTextFormField,
    //       showSearchResultBoard,
    //       null,
    //     ));
    //   },
    // );

    // on<MapEventNearbyPlaces>(
    //   (event, emit) {
    //     final bool showSlider = event.showSlider;
    //     final double radiusValue = event.radiusValue;

    //     emit(MapStateNearbyPlaces(false, showSlider, radiusValue));
    //   },
    // );
  }
}
