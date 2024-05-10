abstract class MapEvent {
  const MapEvent();
}

class MapEventSearchPlaces extends MapEvent {
  final String searchInput;

  const MapEventSearchPlaces({required this.searchInput});
}

class MapEventSearchResultBoard extends MapEvent {
  const MapEventSearchResultBoard();
}

class MapEventGetPlace extends MapEvent {
  final String placeId;

  const MapEventGetPlace({required this.placeId});
}
