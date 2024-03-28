class ChatMessage {
  final String id;
  final String createdBy;
  final String createdByUserName;
  final String message;
  final DateTime timestamp;
  final bool isChat;

  ChatMessage({
    required this.id,
    required this.createdBy,
    required this.createdByUserName,
    required this.message,
    required this.timestamp,
    this.isChat = true,
  });

  Map<String, dynamic> toJSon() {
    return {
      'id': id,
      'createdBy': createdBy,
      'createdByUserName': createdByUserName,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'isChat': isChat,
    };
  }

  factory ChatMessage.fromJSon(Map<String, dynamic> data) {
    return ChatMessage(
      id: data['id'],
      createdBy: data['createdBy'],
      createdByUserName: data['createdByUserName'],
      message: data['message'],
      timestamp: DateTime.parse(data['timestamp']),
      isChat: data['isChat'],
    );
  }
}
