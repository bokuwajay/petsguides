abstract class MapEvent {
  const MapEvent();
}

class MapEventSearchPlaces extends MapEvent {
  final String searchInput;

  const MapEventSearchPlaces({required this.searchInput});
}
