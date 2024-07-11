import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsguides/widgets/build_text_form_field.dart';
import 'package:petsguides/features/map/presentation/bloc/map_bloc.dart';
import 'package:petsguides/features/map/presentation/bloc/map_event.dart';
import 'package:petsguides/features/map/presentation/bloc/map_state.dart';

Widget buildSearchPlacesTextFormField(
  BuildContext context,
  MapState state,
  bool showSearchPlacesTextFormField,
  TextEditingController searchController,
  Timer? _debounce,
  reset,
) {
  if (!showSearchPlacesTextFormField) {
    return Container();
  }
  return Padding(
    padding: const EdgeInsets.fromLTRB(15.0, 40.0, 15.0, 5.0),
    child: Column(
      children: [
        Container(
          height: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            color: Colors.white,
          ),
          child: buildTextFormField(
            controller: searchController,
            hintText: 'search place',
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            suffixIcon: IconButton(
              onPressed: () {
                reset();
              },
              icon: const Icon(Icons.close),
            ),
            onChanged: (value) {
              if (_debounce?.isActive ?? false) {
                _debounce?.cancel();
              }
              _debounce = Timer(const Duration(milliseconds: 700), () async {
                if (value.length > 2) {
                  context.read<MapBloc>().add(
                        MapEventSearchPlaces(searchInput: value),
                      );
                }
              });
            },
          ),
        ),
      ],
    ),
  );
}
