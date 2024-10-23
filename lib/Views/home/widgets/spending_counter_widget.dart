import 'package:flutter/material.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Views/home/widgets/paysa_circle_progress_widget.dart';

class SpendingCounter extends StatelessWidget {
  final String title;
  final double amount;
  final String currency;
  final double targetAmount;

  const SpendingCounter({
    super.key,
    this.title = 'Today',
    this.amount = 181.39,
    this.currency = '\$',
    this.targetAmount = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        // color: PColors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      width: PSize.rw(context, 10) * 0.23,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PaysaCircleProgressWidget(
            size: PSize.rw(context, 10) * 0.2,
            value: 40,
            targetValue: 100,
            foregroundStrokeWidth: 6,
            backgroundStrokeWidth: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: PSize.rw(context, 10) * 0.04,
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
                      style: TextStyle(
                        fontSize: PSize.rw(context, 10) * 0.04,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    Text(
                      ".${amount.toString().split('.').last.padRight(2, '0')}",
                      style: TextStyle(
                        fontSize: PSize.rw(context, 10) * 0.03,
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
    );
  }
}
