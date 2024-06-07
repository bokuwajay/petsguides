abstract class MapEvent {
  const MapEvent();
}

class MapEventSearchPlaces extends MapEvent {
  final String searchInput;

  const MapEventSearchPlaces({required this.searchInput});
}

class MapEventSelectFromSearchList extends MapEvent {
  final String placeId;

  const MapEventSelectFromSearchList({required this.placeId});
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
class MapEventSearchWidgetControl extends MapEvent {
  bool showSearchPlacesTextFormField;
  bool showGetDirection;
  bool showSearchResultBoard;

  MapEventSearchWidgetControl({
    this.showSearchPlacesTextFormField = false,
    this.showGetDirection = false,
    this.showSearchResultBoard = false,
  });
}

class MapEventNearbyPlaces extends MapEvent {
  bool showSlider;
  bool pressNearby;

  MapEventNearbyPlaces({
    this.showSlider = false,
    this.pressNearby = false,
  });
}
