import 'package:paysa/Models/user_split_model.dart';

class SplitSpendingModel {
  final String message;
  final String totalAmount;
  final DateTime dateTime;
  final String? location;
  final List<UserSplitModel> userSplit;
  final String? category;

  SplitSpendingModel({
    required this.message,
    required this.totalAmount,
    required this.dateTime,
    this.location,
    required this.userSplit,
    this.category,
  });

  factory SplitSpendingModel.fromJson(Map<String, dynamic> map) {
    return SplitSpendingModel(
      message: map['message'],
      totalAmount: map['totalAmount'],
      dateTime: DateTime.parse(map['dateTime']),
      location: map['location'],
      userSplit: List<UserSplitModel>.from(
          map['userSplit']?.map((x) => UserSplitModel.fromJson(x))),
      category: map['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'totalAmount': totalAmount,
      'dateTime': dateTime.toIso8601String(),
      'location': location,
      'userSplit': List<dynamic>.from(userSplit.map((x) => x.toJson())),
      'category': category,
    };
  }
}
