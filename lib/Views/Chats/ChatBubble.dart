import 'package:flutter/material.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/helpers/helper_functions.dart';

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

  String getDateDifference(DateTime date) {
    final Duration difference = DateTime.now().difference(date);
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isYou ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment:
              !isYou ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Text(
              getDateDifference(timestamp),
              style: TextStyle(
                fontSize: 10,
                color: isYou ? TColors.primary : TColors.grey.withOpacity(0.6),
                fontWeight: FontWeight.normal,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isYou ? TColors.primary : TColors.darkerGrey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(isYou ? 12 : 0),
                  topRight: Radius.circular(isYou ? 0 : 12),
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                    !isYou ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  Text(
                    isYou ? 'You' : senderName.split(' ').first,
                    style: TextStyle(
                      fontSize: 12,
                      color: isYou
                          ? TColors.white.withOpacity(0.6)
                          : TColors.grey.withOpacity(0.6),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                      fontSize: 16,
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
        ),
      ],
    );
  }
}
