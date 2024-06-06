// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:petsguides/features/map/presentation/bloc/map_bloc.dart';
// import 'package:petsguides/features/map/presentation/bloc/map_event.dart';

// typedef CircleSetter = void Function(LatLng point, updatedRadiusValue);

// Widget buildSlider(
//   BuildContext context,
//   LatLng tappedPoint,
//   double initialRadiusValue,
//   CircleSetter setCircle,
//   Set<Circle> circles,
//   Timer? _debounce,
// ) {
 
//   return Padding(
//     padding: const EdgeInsets.fromLTRB(15.0, 60.0, 15.0, 0.0),
//     child: Container(
//       height: 50.0,
//       color: Colors.black.withOpacity(0.3),
//       child: Row(
//         children: [
//           Expanded(
//               child: Slider(
//             max: 7000.0,
//             min: 1000.0,
//             value: initialRadiusValue,
//             onChanged: (updatedRadiusValue) {
//               // pressedNear = false;
//               setCircle(tappedPoint, updatedRadiusValue);
//             },
//           )),
//           // !pressedNear
//           //     ? IconButton(
//           //         onPressed: () {
//           //           if (_debounce?.isActive ?? false) {
//           //             _debounce?.cancel();
//           //           }
//           //           _debounce = Timer(const Duration(seconds: 2), () async {
//           //             context.read<MapBloc>().add(MapEventGetPlaceDetails(
//           //                 tappedPoint: tappedPoint,
//           //                 radius: radiusValue.toInt()));
//           //             // _markers = {};
//           //             // _markersDupe = _markers;
//           //             // pressedNear = true;
//           //           });
//           //         },
//           //         icon: Icon(Icons.near_me))
//           //     : IconButton(
//           //         onPressed: () {
//           //           if (_debounce?.isActive ?? false) {
//           //             _debounce?.cancel();
//           //           }
//           //           _debounce = Timer(Duration(seconds: 2), () async {
//           //             // if (tokenKey != 'none') {
//           //             //   context.read<MapBloc>().add(
//           //             //       MapEventGetMorePlaceDetails(tokenKey: tokenKey));
//           //             // }
//           //           });
//           //         },
//           //         icon: Icon(
//           //           Icons.more_time,
//           //           color: Colors.blue,
//           //         )),
//           IconButton(
//               onPressed: () {
//                 context
//                     .read<MapBloc>()
//                     .add(MapEventWidgetControl(showNearbyPlaces: false));
//                 circles.clear();
//                 // setState(() {
//                 // radiusSlider = false;
//                 // pressedNear = false;
//                 // cardTapped = false;
//                 initialRadiusValue = 3000.0;
//                 // _circles = {};
//                 // _markers = {};
//                 // allFavoritePlaces = [];
//                 // });
//               },
//               icon: const Icon(
//                 Icons.close,
//                 color: Colors.red,
//               ))
//         ],
//       ),
//     ),
//   );
// }
