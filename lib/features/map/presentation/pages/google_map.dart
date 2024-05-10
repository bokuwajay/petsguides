import 'dart:async';
import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  int markerIdCounter = 1;

  TextEditingController searchController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<MapBloc, MapState>(
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
                      initialCameraPosition: _kGooglePlex,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
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
                                              const MapEventSearchResultBoard());
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
                                          // context.read<MapBloc>().add(
                                          //     const MapEventSearchToggle());
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
                                      ...state.autoComplete!
                                          .map((e) => buildListItem(e))
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
                  setState(() {});
                },
                icon: Icon(Icons.navigation),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> gotoSearchedPlace(double lat, double lng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12)));
  }

  Widget buildListItem(
    AutoCompleteEntity placeItem,
  ) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GestureDetector(
        onTapDown: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onTap: () async {
          // 48:24 call another google API
          // var place = await MapServices().getPlace(placeItem.placeId);
          // gotoSearchedPlace(place['geometry']['location']['lat'], place['geometry']['location']['lng']);
          // searchFlag.toggleSearch();
          context.read<MapBloc>().add(const MapEventSearchResultBoard());
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
