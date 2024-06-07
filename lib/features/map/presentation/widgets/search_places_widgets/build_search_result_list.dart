import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsguides/features/map/domain/entities/auto_complete_entity.dart';
import 'package:petsguides/features/map/presentation/bloc/map_bloc.dart';
import 'package:petsguides/features/map/presentation/bloc/map_event.dart';

Widget buildSearchResultList(
    BuildContext context, AutoCompleteEntity placeItem) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: GestureDetector(
      onTapDown: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onTap: () async {
        context.read<MapBloc>().add(MapEventSearchWidgetControl());
        context.read<MapBloc>().add(
            MapEventSelectFromSearchList(placeId: placeItem.placeId ?? ''));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.location_on,
            color: Colors.green,
            size: 25.0,
          ),
          const SizedBox(width: 4.0),
          SizedBox(
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
