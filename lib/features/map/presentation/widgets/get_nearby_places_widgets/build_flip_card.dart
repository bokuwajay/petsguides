import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:petsguides/features/map/presentation/widgets/get_nearby_places_widgets/build_flip_card_review.dart';

Widget buildFlipCard(
  BuildContext context,
  String placeImg,
  dynamic tappedPlaceDetail,
  toggleReviewPhoto,
  bool isReviews,
  bool isPhotos,
  buildFlipCardGallery,
  bool showFlipCard,
) {
  if (!showFlipCard || tappedPlaceDetail == null) {
    return Container();
  }

  return Positioned(
    top: 120.0,
    left: 15.0,
    child: FlipCard(
      front: Container(
        height: 250.0,
        width: 175.0,
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 150.0,
                width: 175.0,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                  image: DecorationImage(
                      image: NetworkImage(placeImg != ''
                          ? 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=$placeImg&key=${dotenv.env['googleMapKey']}'
                          : 'https://pic.onlinewebfonts.com/svg/img_546302.png'),
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(7.0),
                width: 175.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Address ',
                      style: TextStyle(fontFamily: 'WorkSans', fontSize: 12.0, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 105.0,
                      child: Text(
                        tappedPlaceDetail?['formatted_address'] ?? 'none given',
                        style: const TextStyle(fontFamily: 'WorkSans', fontSize: 11.0, fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 0.0),
                width: 175.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Contact ',
                      style: TextStyle(fontFamily: 'WorkSans', fontSize: 12.0, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 105.0,
                      child: Text(
                        tappedPlaceDetail?['formatted_phone_number'] ?? 'none given',
                        style: const TextStyle(fontFamily: 'WorkSans', fontSize: 11.0, fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      back: Container(
        height: 300.0,
        width: 225.0,
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.95), borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      toggleReviewPhoto();
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeIn,
                      padding: const EdgeInsets.fromLTRB(7.0, 4.0, 7.0, 4.0),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(11.0), color: isReviews ? Colors.green.shade300 : Colors.white),
                      child: Text('Reviews',
                          style: TextStyle(
                            color: isReviews ? Colors.white : Colors.black87,
                            fontFamily: 'WorkSans',
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      toggleReviewPhoto();
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeIn,
                      padding: const EdgeInsets.fromLTRB(7.0, 4.0, 7.0, 4.0),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(11.0), color: isPhotos ? Colors.green.shade300 : Colors.white),
                      child: Text('Photos',
                          style: TextStyle(
                            color: isPhotos ? Colors.white : Colors.black87,
                            fontFamily: 'WorkSans',
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 250.0,
              child: isReviews
                  ? ListView(
                      children: [
                        if (isReviews && tappedPlaceDetail?['reviews'] != null)
                          ...tappedPlaceDetail['reviews']!.map((e) {
                            return buildFlipCardReview(e);
                          })
                      ],
                    )
                  : buildFlipCardGallery(tappedPlaceDetail?['photos'] ?? []),
            )
          ],
        ),
      ),
    ),
  );
}
