import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:petsguides/features/map/domain/entities/auto_complete_entity.dart';

abstract class MapState extends Equatable {
  final List<AutoCompleteEntity>? autoComplete;
  final bool isLoading;
  final bool searchResultBoard;
  final DioException? dioException;
  final Exception? genericException;
  final Map<String, dynamic>? getPlaceResult;
  final Map<String, dynamic>? getDirections;
  final Map<String, dynamic>? getPlaceDetails;
  final Map<String, dynamic>? getMorePlaceDetails;

  const MapState(
      {this.autoComplete,
      this.dioException,
      this.genericException,
      this.getPlaceResult,
      this.getDirections,
      this.getPlaceDetails,
      this.getMorePlaceDetails,
      required this.isLoading,
      required this.searchResultBoard});

  @override
  List<Object?> get props => [
        autoComplete,
        isLoading,
        searchResultBoard,
        dioException,
        genericException,
        getPlaceResult,
        getDirections,
        getPlaceDetails,
        getMorePlaceDetails
      ];
}

class MapStateUninitialized extends MapState {
  const MapStateUninitialized(
      {required bool isLoading, required bool searchResultBoard})
      : super(isLoading: isLoading, searchResultBoard: searchResultBoard);
}

class MapStateSearchPlacesSuccess extends MapState {
  final List<AutoCompleteEntity>? autoComplete;
  MapStateSearchPlacesSuccess(
      {this.autoComplete,
      required bool isLoading,
      required bool searchResultBoard})
      : super(
            autoComplete: autoComplete,
            isLoading: isLoading,
            searchResultBoard: searchResultBoard);
}

class MapStateSearchPlacesFail extends MapState {
  final DioException? dioException;
  final Exception? genericException;

  const MapStateSearchPlacesFail({
    this.dioException,
    this.genericException,
    required bool isLoading,
    required bool searchResultBoard,
  }) : super(
          dioException: dioException,
          genericException: genericException,
          isLoading: isLoading,
          searchResultBoard: searchResultBoard,
        );
}

class MapStateSearchToggle extends MapState {
  MapStateSearchToggle(
      {required bool isLoading, required bool searchResultBoard})
      : super(isLoading: isLoading, searchResultBoard: searchResultBoard);
}

class MapStateGetPlaceSuccess extends MapState {
  final Map<String, dynamic> getPlaceResult;
  MapStateGetPlaceSuccess(
      {required bool isLoading,
      required bool searchResultBoard,
      required this.getPlaceResult})
      : super(
          isLoading: isLoading,
          searchResultBoard: searchResultBoard,
          getPlaceResult: getPlaceResult,
        );
}

class MapStateGetDirectionsSuccess extends MapState {
  final Map<String, dynamic> getDirections;

  MapStateGetDirectionsSuccess({
    required bool isLoading,
    required this.getDirections,
    required bool searchResultBoard,
  }) : super(
          isLoading: isLoading,
          getDirections: getDirections,
          searchResultBoard: searchResultBoard,
        );
}

class MapStateGetPlaceDetailsSuccess extends MapState {
  final Map<String, dynamic> getPlaceDetails;

  MapStateGetPlaceDetailsSuccess({
    required bool isLoading,
    required this.getPlaceDetails,
    required bool searchResultBoard,
  }) : super(
          isLoading: isLoading,
          getPlaceDetails: getPlaceDetails,
          searchResultBoard: searchResultBoard,
        );
}

class MapStateGetMorePlaceDetailsSuccess extends MapState {
  final Map<String, dynamic> getMorePlaceDetails;

  MapStateGetMorePlaceDetailsSuccess({
    required bool isLoading,
    required this.getMorePlaceDetails,
    required bool searchResultBoard,
  }) : super(
          isLoading: isLoading,
          getMorePlaceDetails: getMorePlaceDetails,
          searchResultBoard: searchResultBoard,
        );
}
