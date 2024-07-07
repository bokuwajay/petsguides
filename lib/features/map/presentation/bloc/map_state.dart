import 'package:equatable/equatable.dart';
import 'package:petsguides/features/map/domain/entities/auto_complete_entity.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object?> get props => [];
}

class MapStateInitial extends MapState {}

class MapStateLoading extends MapState {}

// search place
class MapStateSearchPlacesSuccessful extends MapState {
  final List<AutoCompleteEntity>? data;

  const MapStateSearchPlacesSuccessful(
    this.data,
  );

  @override
  List<Object?> get props => [data];
}

class MapStateSearchPlacesFailed extends MapState {
  final String message;

  const MapStateSearchPlacesFailed(this.message);

  @override
  List<Object?> get props => [message];
}

// select place from search result board
class MapStateSelectFromSearchListSuccessful extends MapState {
  final Map<String, dynamic> selectedPlace;

  const MapStateSelectFromSearchListSuccessful(this.selectedPlace);

  @override
  List<Object?> get props => [selectedPlace];
}

class MapStateSelectFromSearchListFailed extends MapState {
  final String message;

  const MapStateSelectFromSearchListFailed(this.message);

  @override
  List<Object?> get props => [message];
}

// get directions
class MapStateGetDirectionsSuccessful extends MapState {
  final Map<String, dynamic> getDirections;
  const MapStateGetDirectionsSuccessful(this.getDirections);

  @override
  List<Object?> get props => [getDirections];
}

class MapStateGetDirectionsFailed extends MapState {
  final String message;

  const MapStateGetDirectionsFailed(this.message);

  @override
  List<Object?> get props => [message];
}

// search within radius
class MapStateSearchInRadiusSuccessful extends MapState {
  final Map<String, dynamic> placesInRadius;

  const MapStateSearchInRadiusSuccessful(this.placesInRadius);

  @override
  List<Object?> get props => [placesInRadius];
}

class MapStateSearchInRadiusFailed extends MapState {
  final String message;

  const MapStateSearchInRadiusFailed(this.message);

  @override
  List<Object?> get props => [message];
}

// get more place in radius
class MapStateGetMorePlacesInRadiusSuccessful extends MapState {
  final Map<String, dynamic> morePlacesInRadius;

  const MapStateGetMorePlacesInRadiusSuccessful(this.morePlacesInRadius);

  @override
  List<Object?> get props => [morePlacesInRadius];
}

class MapStateGetMorePlacesInRadiusFailed extends MapState {
  final String message;

  const MapStateGetMorePlacesInRadiusFailed(this.message);

  @override
  List<Object?> get props => [message];
}

// tap on carousel card
class MapStateTapOnCarouselCardSuccessful extends MapState {
  final Map<String, dynamic> flipCardData;

  const MapStateTapOnCarouselCardSuccessful(this.flipCardData);

  @override
  List<Object?> get props => [flipCardData];
}

class MapStateTapOnCarouselCardFailed extends MapState {
  final String message;

  const MapStateTapOnCarouselCardFailed(this.message);

  @override
  List<Object?> get props => [message];
}
