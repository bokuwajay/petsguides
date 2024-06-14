import 'dart:async';
import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petsguides/features/map/presentation/bloc/map_bloc.dart';
import 'package:petsguides/features/map/presentation/bloc/map_event.dart';
import 'package:petsguides/features/map/presentation/bloc/map_state.dart';
import 'package:petsguides/features/map/presentation/widgets/get_direction_widgets/build_get_direction_text_form_field.dart';
import 'package:petsguides/features/map/presentation/widgets/get_nearby_places_widgets/build_carousel_container.dart';
import 'package:petsguides/features/map/presentation/widgets/get_nearby_places_widgets/build_slider.dart';
import 'package:petsguides/features/map/presentation/widgets/search_places_widgets/build_search_places_text_form_field.dart';
import 'package:petsguides/features/map/presentation/widgets/search_places_widgets/build_search_result_board.dart';
import 'package:petsguides/features/map/utils/get_bytes_from_assets.dart';
import 'package:petsguides/features/map/utils/go_to_origin_destination.dart';
import 'package:petsguides/features/map/utils/go_to_searched_place.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  final TextEditingController _originController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  Set<Marker> _markers = <Marker>{};
  int markerIdCounter = 1;

  Set<Polyline> _polylines = <Polyline>{};
  int polylineIdCounter = 1;

  final Set<Circle> _circles = <Circle>{};
  var tappedPoint;
  var radiusValue = 3000.0;

  //
  //
  //
  //
  //
  //

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
          circleId: const CircleId('raj'),
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

  //
  //
  //
  //
  //
  ////
  //
  //
  //
  //
  //
  // bool searchTextFormField = false;
  // bool radiusSlider = false;
  // bool cardTapped = false;
  // bool pressedNear = false;
  // bool getDirections = false;

  List searchResult = [];

  // Set<Marker> _markersDupe = Set<Marker>();

  // Set<Polyline> _polylines = Set<Polyline>();
  // int markerIdCounter = 1;
  // int polylineIdCounter = 1;

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

  static final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 14.4746);

  // void _setPolyline(List<PointLatLng> points) {
  //   final String polylineIdVal = 'polylin_$polylineIdCounter';
  //   polylineIdCounter++;

  //   _polylines.add(Polyline(
  //       polylineId: PolylineId(polylineIdVal),
  //       width: 2,
  //       color: Colors.blue,
  //       points: points.map((e) => LatLng(e.latitude, e.longitude)).toList()));
  // }

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

  @override
  void initState() {
    _pageController = PageController(initialPage: 1, viewportFraction: 0.85)
      ..addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_pageController.page!.toInt() != prevPage) {
      prevPage = _pageController.page!.toInt();
      // cardTapped = false;
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
        if (state is MapStateSelectFromListSuccess &&
            state.selectedPlace.isNotEmpty) {
          gotoSearchedPlace(
            state.selectedPlace['geometry']['location']['lat'],
            state.selectedPlace['geometry']['location']['lng'],
            _controller.future,
            _setMarker,
          );
        } else if (state is MapStateGetDirectionsSuccess &&
            state.getDirections.isNotEmpty) {
          gotoOriginDestination(
            state.getDirections['start_location']['lat'],
            state.getDirections['start_location']['lng'],
            state.getDirections['end_location']['lat'],
            state.getDirections['end_location']['lng'],
            state.getDirections['bounds_ne'],
            state.getDirections['bounds_sw'],
            _controller.future,
            _setMarker,
          );
          _setPolyline(state.getDirections['polyline_decoded']);
        } else if (state is MapStatePlacesDetailCardsWidgetControl &&
            state.carouselSliderData != null) {
          List<dynamic> placesWithin =
              state.carouselSliderData!['results'] as List;

          allFavoritePlaces = placesWithin;

          tokenKey = state.carouselSliderData!['next_page_token'] ?? 'none';

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
        } else if (state is MapStatePlacesDetailCardsWidgetControl &&
            state.flipCardData != null) {
          tappedPlaceDetail = state.flipCardData;
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
                        _polylines.clear();
                        allFavoritePlaces.clear();
                        // pressedNear = false;
                        // cardTapped = false;
                        _markers.clear();
                        context
                            .read<MapBloc>()
                            .add(MapEventNearbyPlaces(showSlider: true));
                      },
                    ),
                  ),
                  buildSearchPlacesTextFormField(
                      context, state, _searchController, _debounce),
                  buildSearchResultBoard(context, state),
                  buildGetDirectionTextFormField(context, state,
                      _originController, _destinationController),
                  buildSlider(context, state, radiusValue, tappedPoint,
                      _setCircle, _circles, _debounce, tokenKey),
                  buildCarouselContainer(context, state, _pageController,
                      allFavoritePlaces, placeImg, moveCameraSlightly),
                  (state is MapStatePlacesDetailCardsWidgetControl &&
                          state.showFlipDetailCard)
                      ? Positioned(
                          top: 100.0,
                          left: 15.0,
                          child: FlipCard(
                            front: Container(
                              height: 250.0,
                              width: 175.0,
                              decoration: const BoxDecoration(
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
                                        borderRadius: const BorderRadius.only(
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
                                          const Text(
                                            'Address ',
                                            style: TextStyle(
                                                fontFamily: 'WorkSans',
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            width: 105.0,
                                            child: Text(
                                              tappedPlaceDetail?[
                                                      'formatted_address'] ??
                                                  // tappedPlaceDetail[
                                                  //         'formatted_address'] ??
                                                  'none given',
                                              style: const TextStyle(
                                                  fontFamily: 'WorkSans',
                                                  fontSize: 11.0,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          7.0, 0.0, 7.0, 0.0),
                                      width: 175.0,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Contact ',
                                            style: TextStyle(
                                                fontFamily: 'WorkSans',
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            width: 105.0,
                                            child: Text(
                                              tappedPlaceDetail?[
                                                      'formatted_phone_number'] ??
                                                  'none given',
                                              style: const TextStyle(
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
                                            duration: const Duration(
                                                milliseconds: 700),
                                            curve: Curves.easeIn,
                                            padding: const EdgeInsets.fromLTRB(
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
                                            duration: const Duration(
                                                milliseconds: 700),
                                            curve: Curves.easeIn,
                                            padding: const EdgeInsets.fromLTRB(
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
                  _circles.clear();
                  _markers.clear();
                  // pressedNear = false;
                  // cardTapped = false;
                  _searchController.clear();
                  context.read<MapBloc>().add(MapEventSearchWidgetControl(
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
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  _circles.clear();
                  _markers.clear();
                  // pressedNear = false;
                  // cardTapped = false;
                  _originController.clear();
                  _destinationController.clear();
                  context
                      .read<MapBloc>()
                      .add(MapEventSearchWidgetControl(showGetDirection: true));

                  setState(() {
                    // searchTextFormField = false;
                    // radiusSlider = false;
                    // pressedNear = false;
                    // cardTapped = false;
                    // getDirections = true;
                  });
                },
                icon: const Icon(Icons.navigation),
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
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
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
              const SizedBox(
                width: 4.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 160.0,
                    child: Text(
                      review['author_name'],
                      style: const TextStyle(
                          fontFamily: 'WorkSans',
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 3.0),
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
                    animationDuration: const Duration(milliseconds: 1000),
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
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Text(
              review['text'],
              style: const TextStyle(
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
        child: const Center(
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
          const SizedBox(
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
          const SizedBox(
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
                  child: const Center(
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
                style: const TextStyle(
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
                  child: const Center(
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
}
