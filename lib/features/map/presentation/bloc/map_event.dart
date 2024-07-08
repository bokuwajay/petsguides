import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapEvent {
  const MapEvent();
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

  const MapEventGetDirections({required this.origin, required this.destination});
}

// search within radius
class MapEventSearchInRadius extends MapEvent {
  final LatLng tappedPoint;
  final int radius;

  MapEventSearchInRadius({required this.tappedPoint, required this.radius});
}

// get more places in radius
class MapEventGetMorePlacesInRadius extends MapEvent {
  final String nextPageToken;

  const MapEventGetMorePlacesInRadius({required this.nextPageToken});
}

// tap on carousel card
class MapEventTapOnCarouselCard extends MapEvent {
  final String placeId;

  const MapEventTapOnCarouselCard({required this.placeId});
}
