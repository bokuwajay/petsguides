import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petsguides/features/map/presentation/bloc/map_bloc.dart';
import 'package:petsguides/features/map/presentation/bloc/map_event.dart';

Widget buildSlider(BuildContext context, Set<Circle> circles, _setCircle, tappedPoint, Timer? debounce, showSlider, radiusValue, resetLocalVariables) {
  if (!showSlider) {
    return Container();
  }

  return Padding(
    padding: const EdgeInsets.fromLTRB(15.0, 60.0, 15.0, 0.0),
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
              _setCircle(tappedPoint, newVal);
            },
          )),
          IconButton(
              onPressed: () {
                if (debounce?.isActive ?? false) {
                  debounce?.cancel();
                }
                debounce = Timer(const Duration(seconds: 2), () async {
                  context.read<MapBloc>().add(MapEventSearchInRadius(tappedPoint: tappedPoint, radius: radiusValue.toInt()));
                });
              },
              icon: const Icon(Icons.near_me)),
          IconButton(
              onPressed: () {
                resetLocalVariables();
                // circles.clear();
                // setState(() {
                // radiusSlider = false;
                // pressedNear = false;
                // cardTapped = false;
                // radiusValue = 3000.0;
                // _circles = {};
                // _markers = {};
                // allFavoritePlaces = [];
                // });
              },
              icon: const Icon(
                Icons.close,
                color: Colors.red,
              ))
        ],
      ),
    ),
  );
}
