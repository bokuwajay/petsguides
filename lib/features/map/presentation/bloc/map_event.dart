abstract class MapEvent {
  const MapEvent();
}

class MapEventSearchPlaces extends MapEvent {
  final String searchInput;

  const MapEventSearchPlaces({required this.searchInput});
}

class MapEventCloseResultBoard extends MapEvent {
  const MapEventCloseResultBoard();
}

class MapEventGetPlace extends MapEvent {
  final String placeId;

  const MapEventGetPlace({required this.placeId});
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
