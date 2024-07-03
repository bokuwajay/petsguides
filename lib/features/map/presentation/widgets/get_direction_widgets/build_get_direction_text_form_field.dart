import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsguides/components/build_text_form_field.dart';
import 'package:petsguides/features/map/presentation/bloc/map_bloc.dart';
import 'package:petsguides/features/map/presentation/bloc/map_event.dart';
import 'package:petsguides/features/map/presentation/bloc/map_state.dart';

Widget buildGetDirectionTextFormField(
  BuildContext context,
  MapState state,
  TextEditingController _originController,
  TextEditingController _destinationController,
) {
  if (!(state is MapStateSearchWidgetControlSuccessful &&
      state.showGetDirection)) {
    return Container();
  }

  return Padding(
    padding: const EdgeInsets.fromLTRB(15.0, 40.0, 15.0, 5.0),
    child: Column(
      children: [
        Container(
          height: 50.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), color: Colors.white),
          child: buildTextFormField(
              controller: _originController,
              hintText: 'Origin',
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0)),
        ),
        const SizedBox(height: 3.0),
        Container(
            height: 50.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0), color: Colors.white),
            child: buildTextFormField(
              controller: _destinationController,
              hintText: 'Destination',
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              suffixIcon: SizedBox(
                width: 96.0,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        context.read<MapBloc>().add(
                              MapEventGetDirections(
                                  origin: _originController.text,
                                  destination: _destinationController.text),
                            );

                        // _markers = {};
                        // _polylines = {};
                      },
                      icon: const Icon(Icons.search),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<MapBloc>().add(const MapEventReset());
                        // setState(() {
                        // getDirections = false;
                        // _originController.text = '';
                        // _destinationController.text = '';
                        //   _markers = {};
                        //   _polylines = {};
                        // });
                      },
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
              ),
            ))
      ],
    ),
  );
}
