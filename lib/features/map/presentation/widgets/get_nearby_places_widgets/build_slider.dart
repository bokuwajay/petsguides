import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsguides/features/map/presentation/bloc/map_bloc.dart';
import 'package:petsguides/features/map/presentation/bloc/map_event.dart';

Widget buildSlider(
  BuildContext context,
  setCircle,
  tappedPoint,
  Timer? debounce,
  bool showSlider,
  String nextPageToken,
  bool getMorePlaces,
  radiusValue,
  reset,
) {
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
              setCircle(tappedPoint, newVal);
            },
          )),
          getMorePlaces
              ? IconButton(
                  onPressed: () {
                    if (debounce?.isActive ?? false) {
                      debounce?.cancel();
                    }
                    debounce = Timer(const Duration(seconds: 2), () async {
                      context.read<MapBloc>().add(MapEventGetMorePlacesInRadius(nextPageToken: nextPageToken));
                    });
                  },
                  icon: const Icon(Icons.more_time))
              : IconButton(
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
                reset();
              },
              icon: const Icon(Icons.close, color: Colors.red))
        ],
      ),
    ),
  );
}
