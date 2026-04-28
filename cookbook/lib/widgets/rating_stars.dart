
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final double size;

  const RatingStars({super.key, required this.rating, this.size = 14});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return Icon(Icons.star, color: kAccentOrange, size: size);
        } else if (index < rating) {
          return Icon(Icons.star_half, color: kAccentOrange, size: size);
        } else {
          return Icon(Icons.star_border, color: kAccentOrange, size: size);
        }
      }),
    );
  }
}