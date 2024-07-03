import 'package:equatable/equatable.dart';
import 'package:petsguides/features/map/domain/entities/auto_complete_entity.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object?> get props => [];
}

class MapStateInitial extends MapState {}

class MapStateLoading extends MapState {}

// class MapStateException extends MapState {
//   final bool isLoading;
//   final Exception genericException;

//   const MapStateException(this.isLoading, this.genericException)
//       : super(isLoading: isLoading);

//   @override
//   List<Object> get props => [isLoading, genericException];
// }

// class MapStateSearchPlacesSuccessful extends MapState {
//   final List<AutoCompleteEntity>? data;

//   const MapStateSearchPlacesSuccessful(this.data);

//   @override
//   List<Object?> get props => [data];
// }

// class MapStateSearchPlacesFailed extends MapState {
//   final String message;

//   const MapStateSearchPlacesFailed(this.message);

//   @override
//   List<Object?> get props => [message];
// }

// class MapStateSearchWidgetControl extends MapState {
//     final bool showSearchPlacesTextFormField;
//   final bool showGetDirection;

// }

// class MapStateSelectFromListSuccess extends MapState {
//   final bool isLoading;
//   final Map<String, dynamic> selectedPlace;

//   const MapStateSelectFromListSuccess(this.isLoading, this.selectedPlace)
//       : super(isLoading: isLoading);

//   @override
//   List<Object?> get props => [isLoading, selectedPlace];
// }

// class MapStateTapOnPlaceSuccess extends MapState {
//   final bool isLoading;
//   final Map<String, dynamic> tapOnPlaceResult;
//   const MapStateTapOnPlaceSuccess(this.isLoading, this.tapOnPlaceResult)
//       : super(isLoading: isLoading);

//   @override
//   List<Object?> get props => [isLoading, tapOnPlaceResult];
// }

// class MapStateGetDirectionsSuccess extends MapState {
//   final bool isLoading;
//   final Map<String, dynamic> getDirections;

//   const MapStateGetDirectionsSuccess(this.isLoading, this.getDirections)
//       : super(isLoading: isLoading);

//   @override
//   List<Object?> get props => [isLoading, getDirections];
// }

// class MapStatePlacesDetailCardsWidgetControl extends MapState {
//   final bool isLoading;
//   final Map<String, dynamic>? carouselSliderData;
//   final bool showCarouselSlider;
//   final bool showFlipDetailCard;
//   final Map<String, dynamic>? flipCardData;

//   const MapStatePlacesDetailCardsWidgetControl(
//     this.isLoading,
//     this.carouselSliderData,
//     this.showCarouselSlider,
//     this.showFlipDetailCard,
//     this.flipCardData,
//   ) : super(isLoading: isLoading);

//   @override
//   List<Object?> get props => [
//         isLoading,
//         carouselSliderData,
//         showCarouselSlider,
//         showFlipDetailCard,
//         flipCardData
//       ];
// }

// class MapStateGetMorePlaceDetailsSuccess extends MapState {
//   final bool isLoading;
//   final Map<String, dynamic> getMorePlaceDetails;

//   const MapStateGetMorePlaceDetailsSuccess(
//       this.isLoading, this.getMorePlaceDetails)
//       : super(isLoading: isLoading);

//   @override
//   List<Object?> get props => [isLoading, getMorePlaceDetails];
// }

// class MapStateNearbyPlaces extends MapState {
//   final bool isLoading;
//   final bool showSlider;
//   final double radiusValue;

//   const MapStateNearbyPlaces(this.isLoading, this.showSlider, this.radiusValue)
//       : super(isLoading: isLoading);

//   @override
//   List<Object?> get props => [
//         isLoading,
//         showSlider,
//         radiusValue,
//       ];
// }

/////////////////////////////////////////////////////////////////////////////////////////
class MapStateResetSuccessful extends MapState {
  const MapStateResetSuccessful();

  @override
  List<Object?> get props => [];
}

// search place
class MapStateSearchWidgetControlSuccessful extends MapState {
  final bool showSearchPlacesTextFormField;
  final bool showSearchResultBoard;
  final List<AutoCompleteEntity>? data;
  final bool showGetDirection;

  const MapStateSearchWidgetControlSuccessful(
    this.showSearchPlacesTextFormField,
    this.showSearchResultBoard,
    this.data,
    this.showGetDirection,
  );

  @override
  List<Object?> get props => [
        showSearchPlacesTextFormField,
        showSearchResultBoard,
        data,
        showGetDirection,
      ];
}

class MapStateSearchWidgetControlFailed extends MapState {
  final String message;

  const MapStateSearchWidgetControlFailed(this.message);

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
