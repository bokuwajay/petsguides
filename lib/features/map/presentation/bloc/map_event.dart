abstract class MapEvent {
  const MapEvent();
}

class MapEventSearchPlaces extends MapEvent {
  final String searchInput;

  const MapEventSearchPlaces({required this.searchInput});
}

class MapEventTapOnCarouselCard extends MapEvent {
  final String placeId;

  const MapEventTapOnCarouselCard({required this.placeId});
}

class MapEventGetDirections extends MapEvent {
  final String origin;
  final String destination;

  const MapEventGetDirections(
      {required this.origin, required this.destination});
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

// searchPlaces
// get direction

class MapEventNearbyPlaces extends MapEvent {
  bool showSlider;
  double radiusValue;

  MapEventNearbyPlaces({
    this.showSlider = false,
    this.radiusValue = 3000.0,
  });
}

///////////////////////////////////////////////////////////////////////////////////////////////

// search place
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

// select place from search result board
class MapEventSelectFromSearchList extends MapEvent {
  final String placeId;

  const MapEventSelectFromSearchList({required this.placeId});
}
