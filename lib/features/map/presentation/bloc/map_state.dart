import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:petsguides/features/map/domain/entities/auto_complete_entity.dart';

abstract class MapState extends Equatable {
  final List<AutoCompleteEntity>? autoComplete;
  final bool isLoading;
  final bool searchResultBoard;
  final DioException? dioException;
  final Exception? genericException;

  const MapState(
      {this.autoComplete,
      this.dioException,
      this.genericException,
      required this.isLoading,
      required this.searchResultBoard});

  @override
  List<Object?> get props => [
        autoComplete,
        isLoading,
        searchResultBoard,
        dioException,
        genericException
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
