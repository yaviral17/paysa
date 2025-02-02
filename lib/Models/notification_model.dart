class NotificationModel {
  final String title;
  final String body;
  final String token;

  NotificationModel({
    required this.title,
    required this.body,
    required this.token,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> data) {
    return NotificationModel(
      title: data['notification']['title'],
      body: data['notification']['body'],
      token: data['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notification': {
        'title': title,
        'body': body,
      },
      'token': token,
    };
  }
}
