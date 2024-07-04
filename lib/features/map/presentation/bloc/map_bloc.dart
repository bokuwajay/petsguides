import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petsguides/core/util/failure_converter.dart';
import 'package:petsguides/features/map/domain/usecases/map_get_directions_usecase.dart';
import 'package:petsguides/features/map/domain/usecases/map_search_in_radius_usecase.dart';
import 'package:petsguides/features/map/domain/usecases/map_search_places_usecase.dart';
import 'package:petsguides/features/map/domain/usecases/map_select_from_search_list_usecase.dart';
import 'package:petsguides/features/map/domain/usecases/map_tap_on_carousel_card_usecase.dart';
import 'package:petsguides/features/map/domain/usecases/usecase_params.dart';
import 'package:petsguides/features/map/presentation/bloc/map_event.dart';
import 'package:petsguides/features/map/presentation/bloc/map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final MapSearchPlacesUseCase _mapSearchPlacesUseCase;
  final MapSelectFromSearchListUseCase _mapSelectFromSearchListUseCase;
  final MapGetDirectionsUseCase _mapGetDirectionsUseCase;
  final MapSearchInRadiusUseCase _mapSearchInRadiusUseCase;
  final MapTapOnCarouselCardUseCase _mapTapOnCarouselCardUseCase;

  MapBloc(
    this._mapSearchPlacesUseCase,
    this._mapSelectFromSearchListUseCase,
    this._mapGetDirectionsUseCase,
    this._mapSearchInRadiusUseCase,
    this._mapTapOnCarouselCardUseCase,
  ) : super(MapStateInitial()) {
    on<MapEventReset>(
      (event, emit) {
        emit(const MapStateResetSuccessful());
      },
    );

    on<MapEventSearchWidgetControl>(
      (event, emit) {
        final bool showSearchPlacesTextFormField =
            event.showSearchPlacesTextFormField;
        final bool showSearchResultBoard = event.showSearchResultBoard;
        final bool showGetDirection = event.showGetDirection;

        emit(MapStateSearchWidgetControlSuccessful(
          showSearchPlacesTextFormField,
          showSearchResultBoard,
          null,
          showGetDirection,
        ));
      },
    );

    on<MapEventSearchPlaces>((event, emit) async {
      // emit(MapStateLoading());

      final result = await _mapSearchPlacesUseCase
          .call(SearchPlacesParams(searchInput: event.searchInput));
      result.fold(
          (l) => emit(MapStateSearchWidgetControlFailed(failureConverter(l))),
          (r) => emit(
              MapStateSearchWidgetControlSuccessful(true, true, r, false)));
    });

    on<MapEventSelectFromSearchList>(
      (event, emit) async {
        // emit(MapStateLoading());
        final result = await _mapSelectFromSearchListUseCase
            .call(SelectFromSearchListParams(placeId: event.placeId));

        result.fold(
            (l) =>
                emit(MapStateSelectFromSearchListFailed(failureConverter(l))),
            (r) => emit(MapStateSelectFromSearchListSuccessful(r)));
      },
    );

    on<MapEventGetDirections>(
      (event, emit) async {
        // emit(MapStateLoading());
        final result = await _mapGetDirectionsUseCase.call(GetDirectionsParams(
            origin: event.origin, destination: event.destination));

        result.fold(
            (l) => emit(MapStateGetDirectionsFailed(failureConverter(l))),
            (r) => emit(MapStateGetDirectionsSuccessful(r)));
      },
    );

    on<MapEventNearbyPlacesWidgetControl>(
      (event, emit) {
        final bool showSlider = event.showSlider;
        final double radiusValue = event.radiusValue;
        final LatLng tappedPoint = event.tappedPoint;

        emit(MapStateNearbyPlacesWidgetControlSuccessful(
            showSlider, radiusValue, tappedPoint));
      },
    );

    on<MapEventSearchInRadius>(
      (event, emit) async {
        // emit(MapStateLoading());

        final result = await _mapSearchInRadiusUseCase.call(
            SearchInRadiusParams(
                tappedPoint: event.tappedPoint, radius: event.radius));
        result.fold(
            (l) => emit(MapStateSearchInRadiusFailed(failureConverter(l))),
            (r) => emit(MapStateSearchInRadiusSuccessful(r)));
      },
    );

    on<MapEventTapOnCarouselCard>(
      (event, emit) async {
        // emit(MapStateLoading());
        final result = await _mapTapOnCarouselCardUseCase
            .call(TapOnCarouselCardParams(placeId: event.placeId));

        result.fold(
            (l) => emit(MapStateTapOnCarouselCardFailed(failureConverter(l))),
            (r) => emit(MapStateTapOnCarouselCardSuccessful(r)));
      },
    );

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

    // on<MapEventNearbyPlaces>(
    //   (event, emit) {
    //     final bool showSlider = event.showSlider;
    //     final double radiusValue = event.radiusValue;

    //     emit(MapStateNearbyPlaces(false, showSlider, radiusValue));
    //   },
    // );
  }
}
