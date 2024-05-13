import 'dart:async';
import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petsguides/features/map/domain/entities/auto_complete_entity.dart';
import 'package:petsguides/features/map/presentation/bloc/map_bloc.dart';
import 'package:petsguides/features/map/presentation/bloc/map_event.dart';
import 'package:petsguides/features/map/presentation/bloc/map_state.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  Completer<GoogleMapController> _controller = Completer();

  Timer? _debounce;

  bool searchTextFormField = false;
  bool radiusSlider = false;
  bool cardTapped = false;
  bool pressedNear = false;
  bool getDirections = false;

  List searchResult = [];

  Set<Marker> _markers = Set<Marker>();
  Set<Polyline> _polylines = Set<Polyline>();
  int markerIdCounter = 1;
  int polylineIdCounter = 1;

  var radiusValue = 3000.0;

  Set<Circle> _circles = Set<Circle>();

  TextEditingController searchController = TextEditingController();
  TextEditingController _originController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();

  static final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 14.4746);

  void _setMarker(point) {
    var counter = markerIdCounter++;

    final Marker marker = Marker(
      markerId: MarkerId('marker_$counter'),
      position: point,
      onTap: () {},
      icon: BitmapDescriptor.defaultMarker,
    );

    setState(() {
      _markers.add(marker);
    });
  }

  void _setPolyline(List<PointLatLng> points) {
    final String polylineIdVal = 'polylin_$polylineIdCounter';
    polylineIdCounter++;

    _polylines.add(Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 2,
        color: Colors.blue,
        points: points.map((e) => LatLng(e.latitude, e.longitude)).toList()));
  }

  void _setCircle(LatLng point) async {
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: point, zoom: 12)));

    setState(() {
      _circles.add(Circle(
          circleId: CircleId('raj'),
          center: point,
          fillColor: Colors.blue.withOpacity(0.1),
          radius: radiusValue,
          strokeColor: Colors.blue,
          strokeWidth: 1));
      getDirections = false;
      searchTextFormField = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<MapBloc, MapState>(
      listener: (context, state) {
        if (state is MapStateGetPlaceSuccess &&
            state.getPlaceResult.isNotEmpty) {
          gotoSearchedPlace(
            state.getPlaceResult['geometry']['location']['lat'],
            state.getPlaceResult['geometry']['location']['lng'],
          );
        } else if (state is MapStateGetDirectionsSuccess &&
            state.getDirections.isNotEmpty) {
          gotoPlace(
              state.getDirections['start_location']['lat'],
              state.getDirections['start_location']['lng'],
              state.getDirections['end_location']['lat'],
              state.getDirections['end_location']['lng'],
              state.getDirections['bounds_ne'],
              state.getDirections['bounds_sw']);
          _setPolyline(state.getDirections['polyline_decoded']);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(children: [
                  Container(
                    height: screenHeight,
                    width: screenWidth,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      markers: _markers,
                      polylines: _polylines,
                      circles: _circles,
                      initialCameraPosition: _kGooglePlex,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      onTap: (point) {
                        _setCircle(point);
                      },
                    ),
                  ),
                  searchTextFormField
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(15.0, 40.0, 15.0, 5.0),
                          child: Column(
                            children: [
                              Container(
                                height: 50.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white),
                                child: TextFormField(
                                  controller: searchController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 15.0),
                                    border: InputBorder.none,
                                    hintText: "Search",
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          searchTextFormField = false;
                                          searchController.text = '';
                                          _markers = {};
                                          context.read<MapBloc>().add(
                                              const MapEventCloseResultBoard());
                                        });
                                      },
                                      icon: Icon(Icons.close),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    if (_debounce?.isActive ?? false) {
                                      _debounce?.cancel();
                                    }
                                    _debounce = Timer(
                                        Duration(milliseconds: 700), () async {
                                      if (value.length > 2) {
                                        // here to call google API get the search of List<Place>
                                        if (!state.searchResultBoard) {
                                          _markers = {};
                                        }

                                        context.read<MapBloc>().add(
                                              MapEventSearchPlaces(
                                                searchInput: value,
                                              ),
                                            );
                                      }
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      : Container(),

                  // if the search of List<Place> > 0, then show the below
                  (state.searchResultBoard)
                      ? Positioned(
                          top: 100.0,
                          left: 15.0,
                          child: Container(
                            height: 200.0,
                            width: screenWidth - 30.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white.withOpacity(0.7),
                            ),
                            child: (state is MapStateSearchPlacesSuccess &&
                                    state.autoComplete!.isNotEmpty)
                                ? ListView(
                                    children: [
                                      ...state.autoComplete!.map((placeItem) =>
                                          buildListItem(placeItem))
                                    ],
                                  )
                                : Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          "No results to show",
                                          style: TextStyle(
                                              fontFamily: 'WorkSans',
                                              fontWeight: FontWeight.w200),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Container(
                                          width: 125.0,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                // searchFlag.toggleSearch();
                                              },
                                              child: Center(
                                                child: Text(
                                                  'Close this',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'WorkSans',
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                          ))
                      : Container(),
                  getDirections
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(15.0, 40.0, 15.0, 5.0),
                          child: Column(
                            children: [
                              Container(
                                height: 50.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white),
                                child: TextFormField(
                                  controller: _originController,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15.0),
                                      border: InputBorder.none,
                                      hintText: 'Origin'),
                                ),
                              ),
                              SizedBox(
                                height: 3.0,
                              ),
                              Container(
                                height: 50.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white),
                                child: TextFormField(
                                  controller: _destinationController,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15.0),
                                      border: InputBorder.none,
                                      hintText: 'Destination',
                                      suffixIcon: Container(
                                        width: 96.0,
                                        child: Row(
                                          children: [
                                            IconButton(
                                              onPressed: () async {
                                                context.read<MapBloc>().add(
                                                      MapEventGetDirections(
                                                          origin:
                                                              _originController
                                                                  .text,
                                                          destination:
                                                              _destinationController
                                                                  .text),
                                                    );

                                                _markers = {};
                                                _polylines = {};
                                              },
                                              icon: Icon(Icons.search),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  getDirections = false;
                                                  _originController.text = '';
                                                  _destinationController.text =
                                                      '';
                                                  _markers = {};
                                                  _polylines = {};
                                                });
                                              },
                                              icon: Icon(Icons.close),
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                              )
                            ],
                          ),
                        )
                      : Container()
                ])
              ],
            ),
          ),
          floatingActionButton: FabCircularMenuPlus(
            alignment: Alignment.bottomLeft,
            fabColor: Colors.blue.shade50,
            fabOpenColor: Colors.red.shade100,
            ringDiameter: 250.0,
            ringWidth: 60.0,
            ringColor: Colors.blue.shade50,
            fabSize: 60.0,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  setState(() {
                    searchTextFormField = true;
                    radiusSlider = false;
                    pressedNear = false;
                    cardTapped = false;
                    getDirections = false;
                  });
                },
                icon: Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    searchTextFormField = false;
                    radiusSlider = false;
                    pressedNear = false;
                    cardTapped = false;
                    getDirections = true;
                  });
                },
                icon: Icon(Icons.navigation),
              ),
            ],
          ),
        );
      },
    );
  }

  gotoPlace(double lat, double lng, double endLat, double endLng,
      Map<String, dynamic> boundNe, Map<String, dynamic> boundSw) async {
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(
            southwest: LatLng(boundSw['lat'], boundSw['lng']),
            northeast: LatLng(boundNe['lat'], boundNe['lng'])),
        25));

    _setMarker(LatLng(lat, lng));
    _setMarker(LatLng(endLat, endLng));
  }

  Future<void> gotoSearchedPlace(double lat, double lng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12)));
    _setMarker(LatLng(lat, lng));
  }

  Widget buildListItem(AutoCompleteEntity placeItem) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GestureDetector(
        onTapDown: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onTap: () async {
          context.read<MapBloc>().add(const MapEventCloseResultBoard());
          context
              .read<MapBloc>()
              .add(MapEventGetPlace(placeId: placeItem.placeId ?? ''));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              color: Colors.green,
              size: 25.0,
            ),
            SizedBox(
              width: 4.0,
            ),
            Container(
              height: 40.0,
              width: MediaQuery.of(context).size.width - 75.0,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(placeItem.description ?? ''),
              ),
            )
          ],
        ),
      ),
    );
  }
}
