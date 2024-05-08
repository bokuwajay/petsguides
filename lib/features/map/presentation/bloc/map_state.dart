import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:petsguides/features/map/domain/entities/auto_complete_entity.dart';

abstract class MapState extends Equatable {
  final List<AutoCompleteEntity>? autoComplete;
  final bool isLoading;
  final DioException? dioException;
  final Exception? genericException;

  const MapState(
      {this.autoComplete,
      this.dioException,
      this.genericException,
      required this.isLoading});

  @override
  List<Object?> get props => [autoComplete, isLoading];
}

class MapStateUninitialized extends MapState {
  const MapStateUninitialized({required bool isLoading})
      : super(isLoading: isLoading);
}

class MapStateSearchPlacesSuccess extends MapState {
  final List<AutoCompleteEntity>? autoComplete;
  const MapStateSearchPlacesSuccess(
      {this.autoComplete, required bool isLoading})
      : super(autoComplete: autoComplete, isLoading: isLoading);
}

class MapStateSearching extends MapState {
  const MapStateSearching({required bool isLoading})
      : super(isLoading: isLoading);
}

class MapStateSearchPlacesFail extends MapState {
  final DioException? dioException;
  final Exception? genericException;

  const MapStateSearchPlacesFail({
    this.dioException,
    this.genericException,
    required bool isLoading,
  }) : super(
          dioException: dioException,
          genericException: genericException,
          isLoading: isLoading,
        );
}

class MapStateSearchToggle extends MapState {
  final bool isSearchToggle;
  MapStateSearchToggle({required bool isLoading, this.isSearchToggle = false})
      : super(isLoading: isLoading);
}
