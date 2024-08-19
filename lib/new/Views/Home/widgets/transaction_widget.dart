import 'package:flutter/material.dart';
import 'package:paysa/utils/constants/colors.dart';

import '../../../../utils/constants/sizes.dart';

class TransactionWidget extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final String amount;
  final bool isReceived;
  const TransactionWidget({
    super.key,
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.amount,
    this.isReceived = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: TColors.white.withOpacity(0.1),
        child: Center(
          child: Text(
            emoji,
            style: const TextStyle(
              color: TColors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: TColors.white,
          fontSize: TSizes.displayWidth(context) * 0.04,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: TColors.textSecondary,
          fontSize: TSizes.displayWidth(context) * 0.036,
          fontWeight: FontWeight.w600,
          fontFamily: 'OpenSans',
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: TColors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          isReceived ? '+ \$$amount' : '- \$$amount',
          style: TextStyle(
            color: isReceived ? TColors.success : TColors.error,
            fontSize: TSizes.displayWidth(context) * 0.045,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}
