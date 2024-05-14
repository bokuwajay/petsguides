import 'dart:async';
import 'dart:typed_data';
import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petsguides/features/map/domain/entities/auto_complete_entity.dart';
import 'package:petsguides/features/map/presentation/bloc/map_bloc.dart';
import 'package:petsguides/features/map/presentation/bloc/map_event.dart';
import 'package:petsguides/features/map/presentation/bloc/map_state.dart';

import 'dart:ui' as ui;

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
  Set<Marker> _markersDupe = Set<Marker>();

  Set<Polyline> _polylines = Set<Polyline>();
  int markerIdCounter = 1;
  int polylineIdCounter = 1;

  var radiusValue = 3000.0;

  var tappedPoint;

  List allFavoritePlaces = [];

  String tokenKey = '';

  late PageController _pageController;
  int prevPage = 0;
  var tappedPlaceDetail;
  String placeImg = '';
  var photoGalleryIndex = 0;
  bool showBlankCard = false;

  final key = 'AIzaSyDvM7vtrGRyn3Ie3Fcpf0EJJ_8dN4WA4e8';

  var selectedPlaceDetails;

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
      radiusSlider = true;
    });
  }

  _setNearMarker(LatLng point, String label, List types, String status) async {
    var counter = markerIdCounter++;
    final Uint8List markerIcon;

    if (types.contains('restaurants')) {
      markerIcon =
          await getBytesFromAsset('assets/mapicons/restaurants.png', 75);
    } else if (types.contains('food')) {
      markerIcon = await getBytesFromAsset('assets/mapicons/food.png', 75);
    } else if (types.contains('school')) {
      markerIcon = await getBytesFromAsset('assets/mapicons/schools.png', 75);
    } else if (types.contains('bar')) {
      markerIcon = await getBytesFromAsset('assets/mapicons/bars.png', 75);
    } else if (types.contains('lodging')) {
      markerIcon = await getBytesFromAsset('assets/mapicons/hotels.png', 75);
    } else if (types.contains('store')) {
      markerIcon =
          await getBytesFromAsset('assets/mapicons/retail-stores.png', 75);
    } else if (types.contains('locality')) {
      markerIcon =
          await getBytesFromAsset('assets/mapicons/local-services.png', 75);
    } else {
      markerIcon = await getBytesFromAsset('assets/mapicons/places.png', 75);
    }

    final Marker marker = Marker(
        markerId: MarkerId('marker_$counter'),
        position: point,
        onTap: () {},
        icon: BitmapDescriptor.fromBytes(markerIcon));

    setState(() {
      _markers.add(marker);
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);

    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();

    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 1, viewportFraction: 0.85)
      ..addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_pageController.page!.toInt() != prevPage) {
      prevPage = _pageController.page!.toInt();
      cardTapped = false;
      photoGalleryIndex = 1;
      showBlankCard = false;
      gotoTappedPlace();
      fetchImage();
    }
  }

  void fetchImage() async {
    if (_pageController.page != null) {
      if (allFavoritePlaces[_pageController.page!.toInt()]['photo'] != null) {
        setState(() {
          placeImg = allFavoritePlaces[_pageController.page!.toInt()]['photo']
              [0]['photo_reference'];
        });
      } else {
        placeImg = '';
      }
    }
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
        } else if (state is MapStateGetPlaceDetailsSuccess) {
          List<dynamic> placesWithin = state.getPlaceDetails['results'] as List;

          allFavoritePlaces = placesWithin;

          tokenKey = state.getPlaceDetails['next_page_token'] ?? 'none';

          placesWithin.forEach((element) {
            _setNearMarker(
              LatLng(element['geometry']['location']['lat'],
                  element['geometry']['location']['lng']),
              element['name'],
              element['types'],
              element['business_status'] ?? 'not available',
            );
          });
        } else if (state is MapStateGetMorePlaceDetailsSuccess) {
          List<dynamic> placesWithin =
              state.getMorePlaceDetails['results'] as List;
          allFavoritePlaces.addAll(placesWithin);

          tokenKey = state.getMorePlaceDetails['next_page_token'] ?? 'none';

          placesWithin.forEach((element) {
            _setNearMarker(
              LatLng(element['geometry']['location']['lat'],
                  element['geometry']['location']['lng']),
              element['name'],
              element['types'],
              element['business_status'] ?? 'not available',
            );
          });
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
                        tappedPoint = point;
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
                      : Container(),
                  radiusSlider
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(15.0, 60.0, 15.0, 0.0),
                          child: Container(
                            height: 50.0,
                            color: Colors.black.withOpacity(0.3),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Slider(
                                  max: 7000.0,
                                  min: 1000.0,
                                  value: radiusValue,
                                  onChanged: (newVal) {
                                    radiusValue = newVal;
                                    pressedNear = false;
                                    _setCircle(tappedPoint);
                                  },
                                )),
                                !pressedNear
                                    ? IconButton(
                                        onPressed: () {
                                          if (_debounce?.isActive ?? false) {
                                            _debounce?.cancel();
                                          }
                                          _debounce = Timer(
                                              Duration(seconds: 2), () async {
                                            context.read<MapBloc>().add(
                                                MapEventGetPlaceDetails(
                                                    tappedPoint: tappedPoint,
                                                    radius:
                                                        radiusValue.toInt()));
                                            _markers = {};
                                            _markersDupe = _markers;
                                            pressedNear = true;
                                          });
                                        },
                                        icon: Icon(Icons.near_me))
                                    : IconButton(
                                        onPressed: () {
                                          if (_debounce?.isActive ?? false) {
                                            _debounce?.cancel();
                                          }
                                          _debounce = Timer(
                                              Duration(seconds: 2), () async {
                                            if (tokenKey != 'none') {
                                              context.read<MapBloc>().add(
                                                  MapEventGetMorePlaceDetails(
                                                      tokenKey: tokenKey));
                                            }
                                          });
                                        },
                                        icon: Icon(
                                          Icons.mobile_friendly,
                                          color: Colors.white,
                                        ))
                              ],
                            ),
                          ),
                        )
                      : Container(),
                  pressedNear
                      ? Positioned(
                          bottom: 20.0,
                          child: Container(
                            height: 200.0,
                            width: MediaQuery.of(context).size.width,
                            child: PageView.builder(
                                controller: _pageController,
                                itemCount: allFavoritePlaces.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return _nearbyPlacesList(index);
                                }),
                          ))
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

  _nearbyPlacesList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget? widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = (_pageController.page! - index);
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
        onTap: () async {
          cardTapped = !cardTapped;
        },
        child: Stack(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                height: 125.0,
                width: 275.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black54,
                          offset: Offset(0.0, 4.0),
                          blurRadius: 10.0)
                    ]),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white),
                  child: Row(children: [
                    _pageController.position.haveDimensions
                        ? _pageController.page!.toInt() == index
                            ? Container(
                                height: 90.0,
                                width: 90.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10.0),
                                        topLeft: Radius.circular(10.0)),
                                    image: DecorationImage(
                                        image: NetworkImage(placeImg != ''
                                            ? 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=$placeImg&key=$key'
                                            : 'https://pic.onlinewebfonts.com/svg/img_546302.png'),
                                        fit: BoxFit.cover)),
                              )
                            : Container(
                                height: 90.0,
                                width: 20.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0),
                                    ),
                                    color: Colors.blue),
                              )
                        : Container(),
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> gotoTappedPlace() async {
    final GoogleMapController controller = await _controller.future;

    _markers = {};

    var selectedPlace = allFavoritePlaces[_pageController.page!.toInt()];

    _setNearMarker(
        LatLng(selectedPlace['geometry']['location']['lat'],
            selectedPlace['geometry']['location']['lng']),
        selectedPlace['name'] ?? 'no name',
        selectedPlace['types'],
        selectedPlace['business_status'] ?? 'none');

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(selectedPlace['geometry']['location']['lat'],
            selectedPlace['geometry']['location']['lng']),
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
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
