import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:petsguides/features/map/presentation/bloc/map_bloc.dart';
import 'package:petsguides/features/map/presentation/bloc/map_event.dart';
import 'package:petsguides/features/map/presentation/bloc/map_state.dart';

Widget buildCarouselContainer(
  BuildContext context,
  MapState state,
  pageController,
  allFavoritePlaces,
  placeImg,
  moveCameraSlightly,
) {
  if (!(state is MapStatePlacesDetailCardsWidgetControl &&
      state.showCarouselSlider)) {
    return Container();
  }

  return Positioned(
      bottom: 20.0,
      child: SizedBox(
        height: 200.0,
        width: MediaQuery.of(context).size.width,
        child: PageView.builder(
            controller: pageController,
            itemCount: allFavoritePlaces.length,
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              return _nearbyPlacesList(index, pageController, allFavoritePlaces,
                  placeImg, moveCameraSlightly);
            }),
      ));
}

_nearbyPlacesList(
    index, pageController, allFavoritePlaces, placeImg, moveCameraSlightly) {
  const key = 'AIzaSyDvM7vtrGRyn3Ie3Fcpf0EJJ_8dN4WA4e8';
  return AnimatedBuilder(
      animation: pageController,
      builder: (BuildContext context, Widget? widget) {
        double value = 1;
        if (pageController.position.haveDimensions) {
          value = (pageController.page! - index);
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: Builder(
        builder: (context) => InkWell(
          onTap: () async {
            context.read<MapBloc>().add(MapEventTapOnCarouselCard(
                placeId: allFavoritePlaces[index]['place_id']));

            moveCameraSlightly();
          },
          child: Stack(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20.0),
                  height: 125.0,
                  width: 275.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 10.0)
                      ]),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white),
                      child: Row(children: [
                        pageController.position.haveDimensions
                            ? pageController.page!.toInt() == index
                                ? Container(
                                    height: 90.0,
                                    width: 90.0,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(10.0),
                                            topLeft: Radius.circular(10.0)),
                                        image: DecorationImage(
                                            image: NetworkImage(placeImg != ''
                                                ? 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=$placeImg&key=$key'
                                                : 'https://pic.onlinewebfonts.com/svg/img_546302.png'),
                                            fit: BoxFit.cover)),
                                  )
                                : Container(
                                    height: 90.0,
                                    width: 20.0,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10.0),
                                          topLeft: Radius.circular(10.0),
                                        ),
                                        color: Colors.blue),
                                  )
                            : Container(),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 170.0,
                              child: Text(
                                allFavoritePlaces[index]['name'],
                                style: const TextStyle(
                                    fontSize: 12.5,
                                    fontFamily: 'WorkSans',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            RatingStars(
                              value: allFavoritePlaces[index]['rating']
                                          .runtimeType ==
                                      int
                                  ? allFavoritePlaces[index]['rating'] * 1.0
                                  : allFavoritePlaces[index]['rating'] ?? 0.0,
                              starCount: 5,
                              starSize: 10,
                              valueLabelColor: const Color(0xff9b9b9b),
                              valueLabelTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'WorkSans',
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.0),
                              valueLabelRadius: 10,
                              maxValue: 5,
                              starSpacing: 2,
                              maxValueVisibility: false,
                              valueLabelVisibility: true,
                              animationDuration:
                                  const Duration(milliseconds: 1000),
                              valueLabelPadding: const EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 8),
                              valueLabelMargin: const EdgeInsets.only(right: 4),
                              starOffColor: const Color(0xffe7e8ea),
                              starColor: Colors.yellow,
                            ),
                            SizedBox(
                              width: 170.0,
                              child: Text(
                                allFavoritePlaces[index]['business_status'] ??
                                    'none',
                                style: TextStyle(
                                    color: allFavoritePlaces[index]
                                                ['business_status'] ==
                                            'OPERATIONAL'
                                        ? Colors.green
                                        : Colors.red,
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        )
                      ])),
                ),
              )
            ],
          ),
        ),
      ));
}
