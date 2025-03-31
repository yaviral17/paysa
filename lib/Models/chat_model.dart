import 'package:paysa/Models/user_model.dart';

class ChatMessage {
  String id;
  String message;
  DateTime time;
  UserModel sender;
  final bool isSpending;
  final String? spedingId;

  ChatMessage({
    required this.id,
    required this.message,
    required this.time,
    required this.sender,
    this.isSpending = false,
    this.spedingId,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      message: json['message'],
      time: DateTime.parse(json['time']),
      sender: UserModel.fromMap(json['sender']),
      isSpending: json['isSpending'] ?? false,
      spedingId: json['spedingId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'time': time.toIso8601String(),
      'sender': sender.toMap(),
      'isSpending': isSpending,
      'spedingId': spedingId,
    };
  }
}
