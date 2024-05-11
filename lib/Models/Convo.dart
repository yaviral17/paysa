class Convo {
  String id;
  String sender;
  String message;
  String? audio;
  String? image;
  String? split;
  String type;
  DateTime timestamp;
  Convo({
    required this.id,
    required this.sender,
    required this.message,
    required this.timestamp,
    this.audio,
    this.image,
    required this.type,
    this.split,
  });

  factory Convo.fromJson(Map<String, dynamic> json) {
    return Convo(
      id: json['id'],
      sender: json['sender'],
      message: json['message'],
      timestamp: DateTime.parse(json['timestamp']),
      audio: json['audio'],
      image: json['image'],
      type: json['type'],
      split: json['split'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'audio': audio,
      'image': image,
      'type': type,
      'split': split,
    };
  }

  static List<Convo> fromJsonList(List json) {
    List<Convo> result = [];
    for (Map<String, dynamic> item in json) {
      result.add(Convo.fromJson(item));
    }
    return result;
  }

  static List<Map<String, dynamic>> toJsonList(List<Convo> dailySpendings) {
    List<Map<String, dynamic>> data = [];
    for (var dailySpending in dailySpendings) {
      data.add(dailySpending.toJson());
    }
    return data;
  }
}
