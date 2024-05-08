abstract class MapEvent {
  const MapEvent();
}

class MapEventSearchPlaces extends MapEvent {
  final String searchInput;

  const MapEventSearchPlaces({required this.searchInput});
}

class MapEventSearchToggle extends MapEvent {
  final bool searchToggle;
  const MapEventSearchToggle({required this.searchToggle});
}
