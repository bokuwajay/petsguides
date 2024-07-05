import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

Widget buildFlipCardReview(review) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
        child: Row(
          children: [
            Container(
              height: 35.0,
              width: 35.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(review['profile_photo_url']),
                    fit: BoxFit.cover),
              ),
            ),
            const SizedBox(
              width: 4.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 160.0,
                  child: Text(
                    review['author_name'],
                    style: const TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 3.0),
                RatingStars(
                  value: review['rating'] * 1.0,
                  starCount: 5,
                  starSize: 7,
                  valueLabelColor: const Color(0xff9b9b9b),
                  valueLabelTextStyle: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 9.0),
                  valueLabelRadius: 7,
                  maxValue: 5,
                  starSpacing: 2,
                  maxValueVisibility: false,
                  valueLabelVisibility: true,
                  animationDuration: const Duration(milliseconds: 1000),
                  valueLabelPadding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                  valueLabelMargin: const EdgeInsets.only(right: 4),
                  starOffColor: const Color(0xffe7e8ea),
                  starColor: Colors.yellow,
                )
              ],
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Text(
            review['text'],
            style: const TextStyle(
                fontFamily: 'WorkSans',
                fontSize: 11.0,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
      Divider(
        color: Colors.grey.shade600,
        height: 1.0,
      )
    ],
  );
}
