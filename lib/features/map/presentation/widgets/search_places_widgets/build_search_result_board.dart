import 'package:flutter/material.dart';
import 'package:petsguides/features/map/presentation/bloc/map_state.dart';
import 'package:petsguides/features/map/presentation/widgets/search_places_widgets/build_search_result_list.dart';

Widget buildSearchResultBoard(
  BuildContext context,
  MapState state,
) {
  final screenWidth = MediaQuery.of(context).size.width;
  if (state is! MapStateSearchPlacesSuccessful) {
    return Container();
  }

  return Positioned(
      top: 100.0,
      left: 15.0,
      child: Container(
        height: 200.0,
        width: screenWidth - 30.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white.withOpacity(0.7),
        ),
        child: state.data != null
            ? ListView(
                children: [
                  ...state.data!.map(
                      (placeItem) => buildSearchResultList(context, placeItem))
                ],
              )
            : Center(
                child: Column(
                  children: [
                    const Text(
                      "No results to show",
                      style: TextStyle(
                          fontFamily: 'WorkSans', fontWeight: FontWeight.w200),
                    ),
                    const SizedBox(height: 5.0),
                    SizedBox(
                      width: 125.0,
                      child: ElevatedButton(
                          onPressed: () {
                            // searchFlag.toggleSearch();
                          },
                          child: const Center(
                            child: Text(
                              'Close this',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'WorkSans',
                                  fontWeight: FontWeight.w300),
                            ),
                          )),
                    )
                  ],
                ),
              ),
      ));
}
