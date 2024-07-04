import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapEvent {
  const MapEvent();
}

class MapEventGetPlaceDetails extends MapEvent {
  final tappedPoint;
  final int radius;

  const MapEventGetPlaceDetails(
      {required this.tappedPoint, required this.radius});
}

class MapEventGetMorePlaceDetails extends MapEvent {
  final String tokenKey;

  const MapEventGetMorePlaceDetails({required this.tokenKey});
}

///////////////////////////////////////////////////////////////////////////////////////////////

// Reset event
class MapEventReset extends MapEvent {
  const MapEventReset();
}

class MapEventSearchWidgetControl extends MapEvent {
  bool showSearchPlacesTextFormField;
  bool showSearchResultBoard;
  bool showGetDirection;

  MapEventSearchWidgetControl({
    this.showSearchPlacesTextFormField = false,
    this.showSearchResultBoard = false,
    this.showGetDirection = false,
  });
}

// search place
class MapEventSearchPlaces extends MapEvent {
  final String searchInput;

  const MapEventSearchPlaces({required this.searchInput});
}

// select place from search result board
class MapEventSelectFromSearchList extends MapEvent {
  final String placeId;

  const MapEventSelectFromSearchList({required this.placeId});
}

// get directions
class MapEventGetDirections extends MapEvent {
  final String origin;
  final String destination;

  const MapEventGetDirections(
      {required this.origin, required this.destination});
}

// near by places
class MapEventNearbyPlacesWidgetControl extends MapEvent {
  bool showSlider;
  double radiusValue;
  dynamic tappedPoint;

  MapEventNearbyPlacesWidgetControl({
    this.showSlider = false,
    this.radiusValue = 3000.0,
    this.tappedPoint,
  });
}

// search within radius
class MapEventSearchInRadius extends MapEvent {
  final LatLng tappedPoint;
  final int radius;

  MapEventSearchInRadius({required this.tappedPoint, required this.radius});
}

// tap on carousel card
class MapEventTapOnCarouselCard extends MapEvent {
  final String placeId;

  const MapEventTapOnCarouselCard({required this.placeId});
}
