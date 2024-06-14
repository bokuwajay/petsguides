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
  final bool showSearchResultBoard;
  final List<AutoCompleteEntity>? autoComplete;

  const MapStateSearchPlaces(
      this.isLoading, this.showSearchResultBoard, this.autoComplete)
      : super(isLoading: isLoading);

  @override
  List<Object?> get props => [isLoading, showSearchResultBoard, autoComplete];
}

class MapStateSelectFromListSuccess extends MapState {
  final bool isLoading;
  final Map<String, dynamic> selectedPlace;

  const MapStateSelectFromListSuccess(this.isLoading, this.selectedPlace)
      : super(isLoading: isLoading);

  @override
  List<Object?> get props => [isLoading, selectedPlace];
}

// class MapStateTapOnPlaceSuccess extends MapState {
//   final bool isLoading;
//   final Map<String, dynamic> tapOnPlaceResult;
//   const MapStateTapOnPlaceSuccess(this.isLoading, this.tapOnPlaceResult)
//       : super(isLoading: isLoading);

//   @override
//   List<Object?> get props => [isLoading, tapOnPlaceResult];
// }

class MapStateGetDirectionsSuccess extends MapState {
  final bool isLoading;
  final Map<String, dynamic> getDirections;

  const MapStateGetDirectionsSuccess(this.isLoading, this.getDirections)
      : super(isLoading: isLoading);

  @override
  List<Object?> get props => [isLoading, getDirections];
}

class MapStatePlacesDetailCardsWidgetControl extends MapState {
  final bool isLoading;
  final Map<String, dynamic>? carouselSliderData;
  final bool showCarouselSlider;
  final bool showFlipDetailCard;
  final Map<String, dynamic>? flipCardData;

  const MapStatePlacesDetailCardsWidgetControl(
    this.isLoading,
    this.carouselSliderData,
    this.showCarouselSlider,
    this.showFlipDetailCard,
    this.flipCardData,
  ) : super(isLoading: isLoading);

  @override
  List<Object?> get props => [
        isLoading,
        carouselSliderData,
        showCarouselSlider,
        showFlipDetailCard,
        flipCardData
      ];
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

class MapStateSearchWidgetControl extends MapState {
  final bool isLoading;
  final bool showSearchPlacesTextFormField;
  final bool showGetDirection;
  final bool showSearchResultBoard;
  final List<AutoCompleteEntity>? autoComplete;

  const MapStateSearchWidgetControl(
      this.isLoading,
      this.showSearchPlacesTextFormField,
      this.showGetDirection,
      this.showSearchResultBoard,
      this.autoComplete)
      : super(isLoading: isLoading);

  @override
  List<Object?> get props => [
        isLoading,
        showSearchPlacesTextFormField,
        showGetDirection,
        showSearchResultBoard,
        autoComplete,
      ];
}

class MapStateNearbyPlaces extends MapState {
  final bool isLoading;
  final bool showSlider;
  final double radiusValue;

  const MapStateNearbyPlaces(this.isLoading, this.showSlider, this.radiusValue)
      : super(isLoading: isLoading);

  @override
  List<Object?> get props => [
        isLoading,
        showSlider,
        radiusValue,
      ];
}
