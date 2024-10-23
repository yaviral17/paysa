import 'package:flutter/material.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:paysa/Views/home/widgets/paysa_circle_progress_widget.dart';
import 'package:smooth_corner/smooth_corner.dart';

class SpendingChartWidget extends StatelessWidget {
  final String title;
  final double amount;
  final String currency;
  final double targetAmount;

  const SpendingChartWidget({
    super.key,
    this.title = 'Today',
    this.amount = 181.39,
    this.currency = '\$',
    this.targetAmount = 200,
  });

  @override
  Widget build(BuildContext context) {
    return SmoothClipRRect(
      borderRadius: BorderRadius.circular(20),
      smoothness: 0.8,
      child: Container(
        height: 150,
        width: 150,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          // borderRadius: BorderRadius.circular(20),
          color: PColors.black,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PaysaCircleProgressWidget(
              size: 130,
              value: 40,
              animation: false,
              targetValue: 100,
              foregroundStrokeWidth: 6,
              backgroundStrokeWidth: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$currency${amount.toInt()}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                      Text(
                        ".${amount.toString().split('.').last.padRight(2, '0')}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
