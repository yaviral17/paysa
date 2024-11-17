import 'package:flutter/material.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:smooth_corner/smooth_corner.dart';

class CardsWidget extends StatelessWidget {
  Color cardColor;
  CardsWidget({
    this.cardColor = Colors.orange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SmoothContainer(
      smoothness: 1,
      padding: EdgeInsets.all(PSize.arw(context, 15)),
      margin: EdgeInsets.only(right: PSize.arw(context, 15)),
      width: PSize.arw(context, 600),
      height: PSize.arw(context, 190),
      color: cardColor,
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'XXXX 267',
            style: TextStyle(
              fontSize: PSize.arw(context, 18),
            ),
          ),
          SizedBox(
            height: PSize.arw(context, 10),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Balance',
                style: TextStyle(
                  fontSize: PSize.arw(context, 16),
                ),
              ),
              Text(
                '\$1000',
                style: TextStyle(
                  fontSize: PSize.arw(context, 30),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
