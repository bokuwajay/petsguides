import 'package:google_maps_flutter/google_maps_flutter.dart';

typedef MarkerSetter = void Function(LatLng point);

Future<void> gotoSearchedPlace(
  double lat,
  double lng,
  Future<GoogleMapController> googleMapControllerFuture,
  MarkerSetter setMarker,
) async {
  final GoogleMapController controller = await googleMapControllerFuture;
  controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(lat, lng), zoom: 12)));
  setMarker(LatLng(lat, lng));
}
