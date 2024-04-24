import 'dart:developer';

import 'package:get/get_connect/http/src/request/request.dart';
import 'package:paysa/Models/Convo.dart';
import 'package:paysa/Models/DailySpendingModel.dart';

class SessionsModel {
  String id;
  String title;
  List<String> members;
  List<Convo> convoAndTags;
  String icon;
  DateTime timestamp;

  SessionsModel({
    required this.id,
    required this.members,
    this.convoAndTags = const [],
    this.icon = "",
    required this.timestamp,
    required this.title,
  });

  factory SessionsModel.fromJson(Map<String, dynamic> json) {
    return SessionsModel(
      id: json['id'],
      members: json['members'].cast<String>(),
      convoAndTags: Convo.fromJsonList(json['convoAndTags']),
      timestamp: DateTime.parse(json['timestamp']),
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'members': members,
      'convoAndTags': Convo.toJsonList(convoAndTags),
      'icon': icon,
      'timestamp': timestamp.toIso8601String(),
      'title': title,
    };
  }

  static List<SessionsModel> fromJsonList(List<Map<String, dynamic>> json) {
    List<SessionsModel> result = [];
    for (Map<String, dynamic> item in json) {
      result.add(SessionsModel.fromJson(item));
    }
    return result;
  }

  static List<Map<String, dynamic>> toJsonList(
      List<SessionsModel> dailySpendings) {
    List<Map<String, dynamic>> data = [];
    for (var dailySpending in dailySpendings) {
      data.add(dailySpending.toJson());
    }
    return data;
  }

  void logData() {
    log(" id :${id}\n members:${members.toString()}\n convoAndTags:${Convo.toJsonList(convoAndTags).toString()}\n icon: ${icon}\n timestamp: ${timestamp.toIso8601String()}\n title: ${title}");
  }
}
