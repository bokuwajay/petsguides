import 'package:equatable/equatable.dart';
import 'package:petsguides/features/map/domain/entities/auto_complete_entity.dart';

abstract class MapState extends Equatable {
  final bool isLoading;

  const MapState({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class MapStateUninitialized extends MapState {
  const MapStateUninitialized({required bool isLoading})
      : super(isLoading: isLoading);
}

class MapStateException extends MapState {
  final bool isLoading;
  final Exception genericException;

  const MapStateException(this.isLoading, this.genericException)
      : super(isLoading: isLoading);

  @override
  List<Object> get props => [isLoading, genericException];
}

class MapStateSearchPlaces extends MapState {
  final bool isLoading;
  final bool showResultBoard;
  final List<AutoCompleteEntity>? autoComplete;

  const MapStateSearchPlaces(
      this.isLoading, this.showResultBoard, this.autoComplete)
      : super(isLoading: isLoading);

  @override
  List<Object?> get props => [isLoading, showResultBoard, autoComplete];
}

class MapStateGetPlaceSuccess extends MapState {
  final bool isLoading;
  final Map<String, dynamic> getPlaceResult;

  const MapStateGetPlaceSuccess(this.isLoading, this.getPlaceResult)
      : super(isLoading: isLoading);

  @override
  List<Object?> get props => [isLoading, getPlaceResult];
}

class MapStateTapOnPlaceSuccess extends MapState {
  final bool isLoading;
  final Map<String, dynamic> tapOnPlaceResult;
  const MapStateTapOnPlaceSuccess(this.isLoading, this.tapOnPlaceResult)
      : super(isLoading: isLoading);

  @override
  List<Object?> get props => [isLoading, tapOnPlaceResult];
}

class MapStateGetDirectionsSuccess extends MapState {
  final bool isLoading;
  final Map<String, dynamic> getDirections;

  const MapStateGetDirectionsSuccess(this.isLoading, this.getDirections)
      : super(isLoading: isLoading);

  @override
  List<Object?> get props => [isLoading, getDirections];
}

class MapStateGetPlaceDetailsSuccess extends MapState {
  final bool isLoading;
  final Map<String, dynamic> getPlaceDetails;

  const MapStateGetPlaceDetailsSuccess(this.isLoading, this.getPlaceDetails)
      : super(isLoading: isLoading);

  @override
  List<Object?> get props => [isLoading, getPlaceDetails];
}

class MapStateGetMorePlaceDetailsSuccess extends MapState {
  final bool isLoading;
  final Map<String, dynamic> getMorePlaceDetails;

  const MapStateGetMorePlaceDetailsSuccess(
      this.isLoading, this.getMorePlaceDetails)
      : super(isLoading: isLoading);

  @override
  List<Object?> get props => [isLoading, getMorePlaceDetails];
}

class MapStateWidgetControl extends MapState {
  final bool isLoading;
  final bool showSearchPlaces;
  final bool showGetDirection;
  final bool showNearbyPlaces;

  const MapStateWidgetControl(this.isLoading, this.showSearchPlaces,
      this.showGetDirection, this.showNearbyPlaces)
      : super(isLoading: isLoading);

  @override
  List<Object?> get props =>
      [isLoading, showSearchPlaces, showGetDirection, showNearbyPlaces];
}
