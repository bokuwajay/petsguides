import 'package:google_maps_flutter/google_maps_flutter.dart';

typedef MarkerSetter = void Function(LatLng point);

Future<void> gotoOriginDestination(
  double lat,
  double lng,
  double endLat,
  double endLng,
  Map<String, dynamic> boundNe,
  Map<String, dynamic> boundSw,
  Future<GoogleMapController> googleMapControllerFuture,
  MarkerSetter setMarker,
) async {
  final GoogleMapController controller = await googleMapControllerFuture;
  controller.animateCamera(
    CameraUpdate.newLatLngBounds(
      LatLngBounds(
          southwest: LatLng(boundSw['lat'], boundSw['lng']),
          northeast: LatLng(boundNe['lat'], boundNe['lng'])),
      25,
    ),
  );

  setMarker(LatLng(lat, lng));
  setMarker(LatLng(endLat, endLng));
}
