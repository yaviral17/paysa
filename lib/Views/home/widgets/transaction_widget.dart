import 'package:flutter/material.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';

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
        child: Center(
          child: Text(
            emoji,
            style: const TextStyle(
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
          fontSize: PSize.rw(context, 10) * 0.04,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: PColors.secondaryText(context),
          fontSize: PSize.rw(context, 10) * 0.036,
          fontWeight: FontWeight.w600,
          fontFamily: 'OpenSans',
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: PColors.primary(context).withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          isReceived ? '+ \$$amount' : '- \$$amount',
          style: TextStyle(
            color: isReceived ? PColors.success : PColors.error,
            fontSize: PSize.rw(context, 10) * 0.045,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}
