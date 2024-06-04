import 'dart:async';
import 'dart:typed_data';
import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petsguides/components/build_text_form_field.dart';
import 'package:petsguides/features/map/presentation/bloc/map_bloc.dart';
import 'package:petsguides/features/map/presentation/bloc/map_event.dart';
import 'package:petsguides/features/map/presentation/bloc/map_state.dart';
import 'package:petsguides/features/map/presentation/widgets/get_direction_widgets/build_get_direction_text_form_field.dart';
import 'package:petsguides/features/map/presentation/widgets/search_places_widgets/build_search_places_text_form_field.dart';
import 'package:petsguides/features/map/presentation/widgets/search_places_widgets/build_search_result_board.dart';

import 'dart:ui' as ui;

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController searchController = TextEditingController();
  Timer? _debounce;
  TextEditingController _originController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();
  //
  //
  //
  //
  //
  //
  // bool searchTextFormField = false;
  // bool radiusSlider = false;
  bool cardTapped = false;
  bool pressedNear = false;
  // bool getDirections = false;

  List searchResult = [];

  Set<Marker> _markers = Set<Marker>();
  // Set<Marker> _markersDupe = Set<Marker>();

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
  bool isReviews = true;
  bool isPhotos = false;

  final key = 'AIzaSyDvM7vtrGRyn3Ie3Fcpf0EJJ_8dN4WA4e8';

  var selectedPlaceDetails;

  Set<Circle> _circles = Set<Circle>();

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
      // getDirections = false;
      // searchTextFormField = false;
      // radiusSlider = true;
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
      if (allFavoritePlaces[_pageController.page!.toInt()]['photos'] != null) {
        setState(() {
          placeImg = allFavoritePlaces[_pageController.page!.toInt()]['photos']
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
        } else if (state is MapStateTapOnPlaceSuccess &&
            state.tapOnPlaceResult.isNotEmpty) {
          tappedPlaceDetail = state.tapOnPlaceResult;
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(children: [
                  SizedBox(
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
                        context
                            .read<MapBloc>()
                            .add(MapEventWidgetControl(showNearbyPlaces: true));
                      },
                    ),
                  ),
                  buildSearchPlacesTextFormField(
                      context, state, searchController, _debounce),
                  buildSearchResultBoard(context, state),
                  (state is MapStateWidgetControl && state.showGetDirection)
                      ? buildGetDirectionTextFormField(
                          context, _originController, _destinationController)
                      : Container(),
                  (state is MapStateWidgetControl && state.showNearbyPlaces)
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
                                            // _markersDupe = _markers;
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
                                          Icons.more_time,
                                          color: Colors.blue,
                                        )),
                                IconButton(
                                    onPressed: () {
                                      context.read<MapBloc>().add(
                                          MapEventWidgetControl(
                                              showNearbyPlaces: false));
                                      _circles.clear();
                                      setState(() {
                                        // radiusSlider = false;
                                        pressedNear = false;
                                        cardTapped = false;
                                        radiusValue = 3000.0;
                                        // _circles = {};
                                        _markers = {};
                                        allFavoritePlaces = [];
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.red,
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
                      : Container(),
                  cardTapped
                      ? Positioned(
                          top: 100.0,
                          left: 15.0,
                          child: FlipCard(
                            front: Container(
                              height: 250.0,
                              width: 175.0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 150.0,
                                      width: 175.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8.0),
                                            topRight: Radius.circular(8.0)),
                                        image: DecorationImage(
                                            image: NetworkImage(placeImg != ''
                                                ? 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=$placeImg&key=$key'
                                                : 'https://pic.onlinewebfonts.com/svg/img_546302.png'),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(7.0),
                                      width: 175.0,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Address ',
                                            style: TextStyle(
                                                fontFamily: 'WorkSans',
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Container(
                                            width: 105.0,
                                            child: Text(
                                              tappedPlaceDetail?[
                                                      'formatted_address'] ??
                                                  // tappedPlaceDetail[
                                                  //         'formatted_address'] ??
                                                  'none given',
                                              style: TextStyle(
                                                  fontFamily: 'WorkSans',
                                                  fontSize: 11.0,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                          7.0, 0.0, 7.0, 0.0),
                                      width: 175.0,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Contact ',
                                            style: TextStyle(
                                                fontFamily: 'WorkSans',
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Container(
                                            width: 105.0,
                                            child: Text(
                                              tappedPlaceDetail?[
                                                      'formatted_phone_number'] ??
                                                  'none given',
                                              style: TextStyle(
                                                  fontFamily: 'WorkSans',
                                                  fontSize: 11.0,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            back: Container(
                              height: 300.0,
                              width: 225.0,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.95),
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isReviews = true;
                                              isPhotos = false;
                                            });
                                          },
                                          child: AnimatedContainer(
                                            duration:
                                                Duration(milliseconds: 700),
                                            curve: Curves.easeIn,
                                            padding: EdgeInsets.fromLTRB(
                                                7.0, 4.0, 7.0, 4.0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(11.0),
                                                color: isReviews
                                                    ? Colors.green.shade300
                                                    : Colors.white),
                                            child: Text('Reviews',
                                                style: TextStyle(
                                                  color: isReviews
                                                      ? Colors.white
                                                      : Colors.black87,
                                                  fontFamily: 'WorkSans',
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isReviews = false;
                                              isPhotos = true;
                                            });
                                          },
                                          child: AnimatedContainer(
                                            duration:
                                                Duration(milliseconds: 700),
                                            curve: Curves.easeIn,
                                            padding: EdgeInsets.fromLTRB(
                                                7.0, 4.0, 7.0, 4.0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(11.0),
                                                color: isPhotos
                                                    ? Colors.green.shade300
                                                    : Colors.white),
                                            child: Text('Photos',
                                                style: TextStyle(
                                                  color: isPhotos
                                                      ? Colors.white
                                                      : Colors.black87,
                                                  fontFamily: 'WorkSans',
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 250.0,
                                    child: isReviews
                                        ? ListView(
                                            children: [
                                              if (isReviews &&
                                                  tappedPlaceDetail?[
                                                          'reviews'] !=
                                                      null)
                                                ...tappedPlaceDetail['reviews']!
                                                    .map((e) {
                                                  return _buildReviewItem(e);
                                                })
                                            ],
                                          )
                                        : _buildPhotoGallery(
                                            tappedPlaceDetail?['photos'] ?? []),
                                  )
                                ],
                              ),
                            ),
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
                  context.read<MapBloc>().add(MapEventWidgetControl(
                      showSearchPlacesTextFormField: true));
                  _circles.clear();
                  setState(() {
                    // searchTextFormField = true;
                    // radiusSlider = false;
                    // pressedNear = false;
                    // cardTapped = false;
                    // getDirections = false;
                  });
                },
                icon: Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  context
                      .read<MapBloc>()
                      .add(MapEventWidgetControl(showGetDirection: true));
                  _circles.clear();
                  setState(() {
                    // searchTextFormField = false;
                    // radiusSlider = false;
                    // pressedNear = false;
                    // cardTapped = false;
                    // getDirections = true;
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

  _buildReviewItem(review) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
          child: Row(
            children: [
              Container(
                height: 35.0,
                width: 35.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(review['profile_photo_url']),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                width: 4.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 160.0,
                    child: Text(
                      review['author_name'],
                      style: TextStyle(
                          fontFamily: 'WorkSans',
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(height: 3.0),
                  RatingStars(
                    value: review['rating'] * 1.0,
                    starCount: 5,
                    starSize: 7,
                    valueLabelColor: const Color(0xff9b9b9b),
                    valueLabelTextStyle: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 9.0),
                    valueLabelRadius: 7,
                    maxValue: 5,
                    starSpacing: 2,
                    maxValueVisibility: false,
                    valueLabelVisibility: true,
                    animationDuration: Duration(milliseconds: 1000),
                    valueLabelPadding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                    valueLabelMargin: const EdgeInsets.only(right: 4),
                    starOffColor: const Color(0xffe7e8ea),
                    starColor: Colors.yellow,
                  )
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            child: Text(
              review['text'],
              style: TextStyle(
                  fontFamily: 'WorkSans',
                  fontSize: 11.0,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
        Divider(
          color: Colors.grey.shade600,
          height: 1.0,
        )
      ],
    );
  }

  _buildPhotoGallery(photoElement) {
    if (photoElement == null || photoElement.length == 0) {
      showBlankCard = true;
      return Container(
        child: Center(
          child: Text(
            'No Photos',
            style: TextStyle(
                fontFamily: 'WorkSans',
                fontSize: 12.0,
                fontWeight: FontWeight.w500),
          ),
        ),
      );
    } else {
      var placeImg = photoElement[photoGalleryIndex]['photo_reference'];
      var maxWidth = photoElement[photoGalleryIndex]['width'];
      var maxHeight = photoElement[photoGalleryIndex]['height'];
      var tempDisplayIndex = photoGalleryIndex + 1;

      return Column(
        children: [
          SizedBox(
            height: 10.0,
          ),
          Container(
              height: 200.0,
              width: 200.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://maps.googleapis.com/maps/api/place/photo?maxwidth=$maxWidth&maxheight=$maxHeight&photo_reference=$placeImg&key=$key'),
                      fit: BoxFit.cover))),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (photoGalleryIndex != 0) {
                      photoGalleryIndex = photoGalleryIndex - 1;
                    } else {
                      photoGalleryIndex = 0;
                    }
                  });
                },
                child: Container(
                  width: 40.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9.0),
                    color: photoGalleryIndex != 0
                        ? Colors.green.shade500
                        : Colors.grey.shade500,
                  ),
                  child: Center(
                    child: Text(
                      'Prev',
                      style: TextStyle(
                          fontFamily: 'WorkSans',
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              Text(
                '$tempDisplayIndex/' + photoElement.length.toString(),
                style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (photoGalleryIndex != photoElement.length - 1) {
                      photoGalleryIndex = photoGalleryIndex + 1;
                    } else {
                      photoGalleryIndex = photoElement.length - 1;
                    }
                  });
                },
                child: Container(
                  width: 40.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9.0),
                    color: photoGalleryIndex != photoElement.length - 1
                        ? Colors.green.shade500
                        : Colors.grey.shade500,
                  ),
                  child: Center(
                    child: Text(
                      'Next',
                      style: TextStyle(
                          fontFamily: 'WorkSans',
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      );
    }
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

  Future<void> moveCameraSlightly() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(
              allFavoritePlaces[_pageController.page!.toInt()]['geometry']
                      ['location']['lat'] +
                  0.0125,
              allFavoritePlaces[_pageController.page!.toInt()]['geometry']
                      ['location']['lng'] +
                  0.005),
          zoom: 14.0,
          bearing: 45.0,
          tilt: 45.0),
    ));
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
          if (cardTapped) {
            context.read<MapBloc>().add(MapEventTapOnPlace(
                placeId: allFavoritePlaces[index]['place_id']));
            setState(() {});
          }
          moveCameraSlightly();
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
                      SizedBox(
                        width: 5.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 170.0,
                            child: Text(
                              allFavoritePlaces[index]['name'],
                              style: TextStyle(
                                  fontSize: 12.5,
                                  fontFamily: 'WorkSans',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          RatingStars(
                            value: allFavoritePlaces[index]['rating']
                                        .runtimeType ==
                                    int
                                ? allFavoritePlaces[index]['rating'] * 1.0
                                : allFavoritePlaces[index]['rating'] ?? 0.0,
                            starCount: 5,
                            starSize: 10,
                            valueLabelColor: const Color(0xff9b9b9b),
                            valueLabelTextStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: 'WorkSans',
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0),
                            valueLabelRadius: 10,
                            maxValue: 5,
                            starSpacing: 2,
                            maxValueVisibility: false,
                            valueLabelVisibility: true,
                            animationDuration: Duration(milliseconds: 1000),
                            valueLabelPadding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 8),
                            valueLabelMargin: const EdgeInsets.only(right: 4),
                            starOffColor: const Color(0xffe7e8ea),
                            starColor: Colors.yellow,
                          ),
                          Container(
                            width: 170.0,
                            child: Text(
                              allFavoritePlaces[index]['business_status'] ??
                                  'none',
                              style: TextStyle(
                                  color: allFavoritePlaces[index]
                                              ['business_status'] ==
                                          'OPERATIONAL'
                                      ? Colors.green
                                      : Colors.red,
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      )
                    ])),
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
}
