import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  static const LatLng _pGooglePlex = LatLng(22.33900, 114.15059);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        actions: [],
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: _pGooglePlex,
          zoom: 17,
        ),
        markers: {
          const Marker(
            markerId: MarkerId('_currentLocation'),
            icon: BitmapDescriptor.defaultMarker,
            position: _pGooglePlex,
          )
        },
      ),
    );
  }
}
