import 'package:firebase_auth/firebase_auth.dart';
import 'package:paysa/Models/SplitModel.dart';

class DailySpendingModel {
  String id;
  bool isSplit;
  DateTime timestamp;
  double amount;
  String category;
  String title;
  String description;

  DailySpendingModel({
    required this.id,
    required this.timestamp,
    required this.amount,
    required this.category,
    required this.title,
    required this.description,
    required this.isSplit,
  });

  factory DailySpendingModel.fromJson(Map<String, dynamic> json) {
    return DailySpendingModel(
      id: json['id'],
      timestamp: DateTime.parse(json['timestamp']),
      amount: double.parse(json['amount'].toString()),
      category: json['category'],
      title: json['title'],
      description: json['description'],
      isSplit: json['isSplit'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'amount': amount,
      'category': category,
      'title': title,
      'description': description,
      'isSplit': isSplit,
    };
  }

  static List<DailySpendingModel> fromJsonList(
      List<Map<String, dynamic>> json) {
    List<DailySpendingModel> result = [];
    for (Map<String, dynamic> item in json) {
      result.add(DailySpendingModel.fromJson(item));
    }
    return result;
  }

  static List<String> DailySpendingCategories = [
    'accessory',
    'award',
    'beer',
    'boat',
    'book',
    'car',
    'Clothes',
    'coffe',
    'computer',
    'cosmetic',
    'drink',
    'electric',
    'entertainment',
    'fitness',
    'Food',
    'fruit',
    'gift',
    'grocery',
    'gas',
    'home',
    'hotel',
    'icecream',
    'launcher',
    'laundry',
    'medical',
    'noodle',
    'oil',
    'other',
    'people',
    'phone',
    'pill',
    'pizza',
    'plane',
    'restaurant',
    'saving',
    'sell',
    'shopping',
    'sweet',
    'taxi',
    'train',
    'water',
    'working',
  ];

  String get categoryIcon =>
      'assets/expanses_category_icons/ic_${this.category}.png';
}
