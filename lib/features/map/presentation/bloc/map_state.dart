import 'package:equatable/equatable.dart';
import 'package:petsguides/features/map/domain/entities/auto_complete_entity.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object?> get props => [];
}

class MapStateInitial extends MapState {}

class MapStateLoading extends MapState {}

class MapStateFailed extends MapState {
  final String message;

  const MapStateFailed(this.message);

  @override
  List<Object?> get props => [message];
}

// search place
class MapStateSearchPlacesSuccessful extends MapState {
  final List<AutoCompleteEntity>? data;

  const MapStateSearchPlacesSuccessful(
    this.data,
  );

  @override
  List<Object?> get props => [data];
}

// select place from search result board
class MapStateSelectFromSearchListSuccessful extends MapState {
  final Map<String, dynamic> selectedPlace;

  const MapStateSelectFromSearchListSuccessful(this.selectedPlace);

  @override
  List<Object?> get props => [selectedPlace];
}

// get directions
class MapStateGetDirectionsSuccessful extends MapState {
  final Map<String, dynamic> getDirections;
  const MapStateGetDirectionsSuccessful(this.getDirections);

  @override
  List<Object?> get props => [getDirections];
}

// search within radius
class MapStateSearchInRadiusSuccessful extends MapState {
  final Map<String, dynamic> placesInRadius;

  const MapStateSearchInRadiusSuccessful(this.placesInRadius);

  @override
  List<Object?> get props => [placesInRadius];
}

// get more place in radius
class MapStateGetMorePlacesInRadiusSuccessful extends MapState {
  final Map<String, dynamic> morePlacesInRadius;

  const MapStateGetMorePlacesInRadiusSuccessful(this.morePlacesInRadius);

  @override
  List<Object?> get props => [morePlacesInRadius];
}

// tap on carousel card
class MapStateTapOnCarouselCardSuccessful extends MapState {
  final Map<String, dynamic> flipCardData;

  const MapStateTapOnCarouselCardSuccessful(this.flipCardData);

  @override
  List<Object?> get props => [flipCardData];
}
