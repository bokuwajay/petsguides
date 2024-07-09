import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsguides/core/util/failure_converter.dart';
import 'package:petsguides/core/util/logger.dart';
import 'package:petsguides/features/map/domain/usecases/map_get_directions_usecase.dart';
import 'package:petsguides/features/map/domain/usecases/map_get_more_places_in_radius_usecase.dart';
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
  final MapGetMorePlacesInRadiusUseCase _mapGetMorePlacesInRadiusUseCase;
  final MapTapOnCarouselCardUseCase _mapTapOnCarouselCardUseCase;

  MapBloc(
    this._mapSearchPlacesUseCase,
    this._mapSelectFromSearchListUseCase,
    this._mapGetDirectionsUseCase,
    this._mapSearchInRadiusUseCase,
    this._mapGetMorePlacesInRadiusUseCase,
    this._mapTapOnCarouselCardUseCase,
  ) : super(MapStateInitial()) {
    on<MapEventSearchPlaces>((event, emit) async {
      // emit(MapStateLoading());

      final result = await _mapSearchPlacesUseCase.call(SearchPlacesParams(searchInput: event.searchInput));
      result.fold((l) => emit(MapStateSearchPlacesFailed(failureConverter(l))), (r) => emit(MapStateSearchPlacesSuccessful(r)));
    });

    on<MapEventSelectFromSearchList>(
      (event, emit) async {
        // emit(MapStateLoading());
        final result = await _mapSelectFromSearchListUseCase.call(SelectFromSearchListParams(placeId: event.placeId));

        result.fold((l) => emit(MapStateSelectFromSearchListFailed(failureConverter(l))), (r) => emit(MapStateSelectFromSearchListSuccessful(r)));
      },
    );

    on<MapEventGetDirections>(
      (event, emit) async {
        // emit(MapStateLoading());
        final result = await _mapGetDirectionsUseCase.call(GetDirectionsParams(origin: event.origin, destination: event.destination));

        result.fold((l) => emit(MapStateGetDirectionsFailed(failureConverter(l))), (r) => emit(MapStateGetDirectionsSuccessful(r)));
      },
    );

    on<MapEventSearchInRadius>(
      (event, emit) async {
        // emit(MapStateLoading());

        final result = await _mapSearchInRadiusUseCase.call(SearchInRadiusParams(tappedPoint: event.tappedPoint, radius: event.radius));
        result.fold((l) => emit(MapStateSearchInRadiusFailed(failureConverter(l))), (r) => emit(MapStateSearchInRadiusSuccessful(r)));
      },
    );

    on<MapEventGetMorePlacesInRadius>(
      (event, emit) async {
        // emit(MapStateLoading());
        final result = await _mapGetMorePlacesInRadiusUseCase.call(GetMorePlacesInRadiusParams(nextPageToken: event.nextPageToken));
        result.fold((l) => emit(MapStateGetMorePlacesInRadiusFailed(failureConverter(l))), (r) => emit(MapStateGetMorePlacesInRadiusSuccessful(r)));
      },
    );

    on<MapEventTapOnCarouselCard>(
      (event, emit) async {
        // emit(MapStateLoading());
        final result = await _mapTapOnCarouselCardUseCase.call(TapOnCarouselCardParams(placeId: event.placeId));

        result.fold((l) => emit(MapStateTapOnCarouselCardFailed(failureConverter(l))), (r) => emit(MapStateTapOnCarouselCardSuccessful(r)));
      },
    );
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE MapBloc =====");
    return super.close();
  }
}
