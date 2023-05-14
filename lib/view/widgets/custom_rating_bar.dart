import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomRatingBar extends StatelessWidget {
  const CustomRatingBar({
    Key? key,
    required this.initialRating,
    required this.numberOfStars,
  }) : super(key: key);
  //*number of people who rate with the number of stars value
  final double initialRating;
  final int numberOfStars;

  @override
  Widget build(BuildContext context) {
    return RatingBar(
      initialRating: initialRating,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: numberOfStars,
      ignoreGestures: true,
      itemPadding: const EdgeInsets.symmetric(
        horizontal: .5,
      ),
      itemSize: 15,
      ratingWidget: RatingWidget(
        full: const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        empty: const Icon(
          Icons.star_outline,
          color: Colors.grey,
        ),
        half: const Icon(
          Icons.star_half_outlined,
          color: Colors.amber,
        ),
      ),
      onRatingUpdate: (_) {},
    );
  }
}
