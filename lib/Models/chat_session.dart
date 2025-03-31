import 'package:paysa/Models/chat_model.dart';
import 'package:paysa/Models/spending_model.dart';
import 'package:paysa/Models/user_model.dart';
import 'package:paysa/Utils/helpers/helper.dart';

class ChatSession {
  String id;
  List<UserModel> participants;
  List<ChatMessage> messages;
  DateTime createdAt;

  SpendingModel? spendingModel;
  List<String> users;

  ChatSession({
    required this.id,
    required this.participants,
    required this.messages,
    required this.createdAt,
    this.spendingModel,
    required this.users,
  });

  factory ChatSession.fromJson(Map<String, dynamic> json) {
    return ChatSession(
      id: json['id'],
      participants: (json['participants'] as List)
          .map((participant) => UserModel.fromMap(participant))
          .toList(),
      messages: (json['messages'] as List)
          .map((message) => ChatMessage.fromJson(message))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      spendingModel: json['spendingModel'] != null
          ? SpendingModel.fromJson(json['spendingModel'])
          : null,
      users: PHelper.sortAlphabetically(
          (json['users'] as List).map((user) => user.toString()).toList()),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'participants':
          participants.map((participant) => participant.toMap()).toList(),
      'messages': messages.map((message) => message.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'spendingModel': spendingModel?.toJson(),
      'users': PHelper.sortAlphabetically(users),
    };
  }
}
