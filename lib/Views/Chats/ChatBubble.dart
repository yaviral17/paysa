import 'package:flutter/material.dart';
import 'package:paysa/utils/constants/colors.dart';

class ChatBubble extends StatelessWidget {
  final String senderName;
  final String message;
  final DateTime timestamp;
  final bool isYou;

  const ChatBubble({
    Key? key,
    required this.senderName,
    required this.message,
    required this.timestamp,
    required this.isYou,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isYou ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isYou ? TColors.primary : TColors.darkerGrey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   senderName,
              //   style: TextStyle(
              //     fontWeight: FontWeight.bold,
              //     color: Colors.white,
              //   ),
              // ),
              // SizedBox(height: 4),
              Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              // SizedBox(height: 4),
              // Text(
              //   timestamp.toString(),
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 12,
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
