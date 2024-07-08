import 'dart:async';
import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petsguides/features/map/domain/entities/auto_complete_entity.dart';
import 'package:petsguides/features/map/presentation/bloc/map_bloc.dart';
import 'package:petsguides/features/map/presentation/bloc/map_event.dart';
import 'package:petsguides/features/map/presentation/bloc/map_state.dart';
import 'package:petsguides/features/map/presentation/widgets/get_direction_widgets/build_get_direction_text_form_field.dart';
import 'package:petsguides/features/map/presentation/widgets/get_nearby_places_widgets/build_carousel_container.dart';
import 'package:petsguides/features/map/presentation/widgets/get_nearby_places_widgets/build_flip_card.dart';
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
  static final CameraPosition _kGooglePlex = CameraPosition(target: LatLng(37.42796133580664, -122.085749655962), zoom: 14.4746);
  Timer? _debounce;
  late PageController _pageController;

// search places
  bool showSearchPlacesTextFormField = false;
  bool showSearchResultBoard = false;
  final TextEditingController _searchController = TextEditingController();
  final Set<Marker> _markers = <Marker>{};
  int markerIdCounter = 1;
  List<AutoCompleteEntity> searchedPlaces = [];

// get directions
  bool showGetDirections = false;
  final TextEditingController _originController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final Set<Polyline> _polylines = <Polyline>{};
  int polylineIdCounter = 1;

  // get near by within radius
  final Set<Circle> _circles = <Circle>{};
  bool showSlider = false;
  var tappedPoint;
  var radiusValue = 3000.0;
  List placesWithinRadius = [];

  // get more places within radius
  String nextPageToken = '';
  bool getMorePlaces = false;

// tap on carousel card
  var tappedPlaceDetail;
  String placeImg = '';
  bool isReviews = true;
  bool isPhotos = false;
  int prevPage = 0;
  var photoGalleryIndex = 0;
  bool showFlipCard = false;

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
    _polylines.add(
        Polyline(polylineId: PolylineId(polylineIdVal), width: 2, color: Colors.blue, points: points.map((e) => LatLng(e.latitude, e.longitude)).toList()));
  }

  void _setCircle(LatLng point, newVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: point, zoom: 12)));
    setState(() {
      radiusValue = newVal;
      _circles.add(Circle(
          circleId: const CircleId('raj'),
          center: point,
          fillColor: Colors.blue.withOpacity(0.1),
          radius: radiusValue,
          strokeColor: Colors.blue,
          strokeWidth: 1));
      showSlider = true;
    });
  }

  _setNearMarker(LatLng point, String label, List types, String status) async {
    var counter = markerIdCounter++;
    final Uint8List markerIcon;

    if (types.contains('restaurants')) {
      markerIcon = await getBytesFromAsset('assets/mapicons/restaurants.png', 75);
    } else if (types.contains('food')) {
      markerIcon = await getBytesFromAsset('assets/mapicons/food.png', 75);
    } else if (types.contains('school')) {
      markerIcon = await getBytesFromAsset('assets/mapicons/schools.png', 75);
    } else if (types.contains('bar')) {
      markerIcon = await getBytesFromAsset('assets/mapicons/bars.png', 75);
    } else if (types.contains('lodging')) {
      markerIcon = await getBytesFromAsset('assets/mapicons/hotels.png', 75);
    } else if (types.contains('store')) {
      markerIcon = await getBytesFromAsset('assets/mapicons/retail-stores.png', 75);
    } else if (types.contains('locality')) {
      markerIcon = await getBytesFromAsset('assets/mapicons/local-services.png', 75);
    } else {
      markerIcon = await getBytesFromAsset('assets/mapicons/places.png', 75);
    }

    final Marker marker = Marker(markerId: MarkerId('marker_$counter'), position: point, onTap: () {}, icon: BitmapDescriptor.fromBytes(markerIcon));

    setState(() {
      _markers.add(marker);
    });
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 1, viewportFraction: 0.85)..addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_pageController.page!.toInt() != prevPage) {
      prevPage = _pageController.page!.toInt();
      photoGalleryIndex = 1;
      gotoTappedPlace();
      fetchImage();
    }
    if (showFlipCard) {
      context.read<MapBloc>().add(MapEventTapOnCarouselCard(placeId: placesWithinRadius[_pageController.page!.toInt()]['place_id']));
      moveCameraSlightly();
    }
  }

  Future<void> gotoTappedPlace() async {
    final GoogleMapController controller = await _controller.future;

    _markers.clear();
    var selectedPlace = placesWithinRadius[_pageController.page!.toInt()];

    _setNearMarker(LatLng(selectedPlace['geometry']['location']['lat'], selectedPlace['geometry']['location']['lng']), selectedPlace['name'] ?? 'no name',
        selectedPlace['types'], selectedPlace['business_status'] ?? 'none');

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(selectedPlace['geometry']['location']['lat'], selectedPlace['geometry']['location']['lng']), zoom: 14.0, bearing: 45.0, tilt: 45.0)));
  }

  void fetchImage() async {
    if (_pageController.page != null) {
      if (placesWithinRadius[_pageController.page!.toInt()]['photos'] != null) {
        setState(() {
          placeImg = placesWithinRadius[_pageController.page!.toInt()]['photos'][0]['photo_reference'];
        });
      } else {
        placeImg = '';
      }
    }
  }

  Future<void> moveCameraSlightly() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(placesWithinRadius[_pageController.page!.toInt()]['geometry']['location']['lat'] + 0.0125,
                placesWithinRadius[_pageController.page!.toInt()]['geometry']['location']['lng'] + 0.005),
            zoom: 14.0,
            bearing: 45.0,
            tilt: 45.0),
      ),
    );
  }

  void reset() {
    setState(() {
      // clear searh places
      showSearchPlacesTextFormField = false;
      showSearchResultBoard = false;
      _searchController.clear();
      _markers.clear();
      markerIdCounter = 1;
      searchedPlaces = [];

      // clear get directions
      showGetDirections = false;
      _originController.clear();
      _destinationController.clear();
      _polylines.clear();
      polylineIdCounter = 1;

      // clear get near by
      _circles.clear();
      showSlider = false;
      tappedPoint = null;
      radiusValue = 3000.0;
      placesWithinRadius = [];

      // get more places in radius
      nextPageToken = '';
      getMorePlaces = false;

      // tap on carousel card and show flip card
      tappedPlaceDetail = null;
      placeImg = '';
      isReviews = true;
      isPhotos = false;
      prevPage = 0;
      photoGalleryIndex = 0;
      showFlipCard = false;
    });
  }

  void toggleReviewPhoto() {
    setState(() {
      isReviews = !isReviews;
      isPhotos = !isPhotos;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<MapBloc, MapState>(
      listener: (context, state) {
        if (state is MapStateSearchPlacesSuccessful) {
          showSearchResultBoard = true;
          if (state.data != null) {
            searchedPlaces = state.data!;
          } else {
            searchedPlaces = [];
          }
        } else if (state is MapStateSelectFromSearchListSuccessful && state.selectedPlace.isNotEmpty) {
          reset();
          gotoSearchedPlace(
            state.selectedPlace['geometry']['location']['lat'],
            state.selectedPlace['geometry']['location']['lng'],
            _controller.future,
            _setMarker,
          );
        } else if (state is MapStateGetDirectionsSuccessful && state.getDirections.isNotEmpty) {
          reset();
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
        } else if (state is MapStateSearchInRadiusSuccessful && state.placesInRadius.isNotEmpty) {
          getMorePlaces = true;
          placesWithinRadius = state.placesInRadius['results'];
          nextPageToken = state.placesInRadius['next_page_token'] ?? 'none';
          for (var element in placesWithinRadius) {
            _setNearMarker(
              LatLng(element['geometry']['location']['lat'], element['geometry']['location']['lng']),
              element['name'],
              element['types'],
              element['business_status'] ?? 'not available',
            );
          }
        } else if (state is MapStateGetMorePlacesInRadiusSuccessful && state.morePlacesInRadius.isNotEmpty) {
          placesWithinRadius.addAll(state.morePlacesInRadius['results']);
          nextPageToken = state.morePlacesInRadius['next_page_token'] ?? 'none';
          for (var element in placesWithinRadius) {
            _setNearMarker(
              LatLng(element['geometry']['location']['lat'], element['geometry']['location']['lng']),
              element['name'],
              element['types'],
              element['business_status'] ?? 'not available',
            );
          }
        } else if (state is MapStateTapOnCarouselCardSuccessful && state.flipCardData.isNotEmpty) {
          showFlipCard = true;
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
                        reset();
                        tappedPoint = point;
                        _setCircle(point, radiusValue);
                      },
                    ),
                  ),
                  buildSearchPlacesTextFormField(context, state, showSearchPlacesTextFormField, _searchController, _debounce, reset),
                  buildSearchResultBoard(context, showSearchResultBoard, searchedPlaces, reset),
                  buildGetDirectionTextFormField(context, state, showGetDirections, _originController, _destinationController, reset),
                  buildSlider(context, _setCircle, tappedPoint, _debounce, showSlider, nextPageToken, getMorePlaces, radiusValue, reset),
                  buildFlipCard(context, placeImg, tappedPlaceDetail, toggleReviewPhoto, isReviews, isPhotos, buildFlipCardGallery, showFlipCard),
                  buildCarouselContainer(context, placesWithinRadius, _pageController, placeImg, moveCameraSlightly),
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
                  reset();
                  setState(() {
                    showSearchPlacesTextFormField = true;
                  });
                },
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  reset();
                  setState(() {
                    showGetDirections = true;
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

  buildFlipCardGallery(photoElement) {
    if (photoElement == null || photoElement.length == 0) {
      return Container(
        child: const Center(
          child: Text(
            'No Photos',
            style: TextStyle(fontFamily: 'WorkSans', fontSize: 12.0, fontWeight: FontWeight.w500),
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
          const SizedBox(height: 10.0),
          Container(
            height: 200.0,
            width: 200.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage(
                    'https://maps.googleapis.com/maps/api/place/photo?maxwidth=$maxWidth&maxheight=$maxHeight&photo_reference=$placeImg&key=${dotenv.env['googleMapKey']}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
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
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(9.0), color: photoGalleryIndex != 0 ? Colors.green.shade500 : Colors.grey.shade500),
                  child: const Center(
                    child: Text(
                      'Prev',
                      style: TextStyle(fontFamily: 'WorkSans', color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              Text(
                '$tempDisplayIndex/${photoElement.length}',
                style: const TextStyle(fontFamily: 'WorkSans', fontSize: 12.0, fontWeight: FontWeight.w500),
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
                    color: photoGalleryIndex != photoElement.length - 1 ? Colors.green.shade500 : Colors.grey.shade500,
                  ),
                  child: const Center(
                    child: Text(
                      'Next',
                      style: TextStyle(fontFamily: 'WorkSans', color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.w500),
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
}
