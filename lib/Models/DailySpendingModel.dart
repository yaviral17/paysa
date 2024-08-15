
import 'package:paysa/Models/SplitModel.dart';

class DailySpendingModel {
  String id;
  bool isSplit;
  DateTime timestamp;
  double amount;
  String category;
  String title;
  String description;
  String? paidy;
  List<Split>? splits;

  DailySpendingModel({
    required this.id,
    required this.timestamp,
    required this.amount,
    required this.category,
    required this.title,
    required this.description,
    required this.isSplit,
    this.paidy,
    this.splits,
  });

  factory DailySpendingModel.fromJson(Map<String, dynamic> json) {
    // log('DailySpendingModel.fromJson: ${json.toString()}');
    return DailySpendingModel(
      id: json['id'],
      timestamp: DateTime.parse(json['timestamp']),
      amount: double.parse(json['amount'].toString()),
      category:
          json['category'] ?? DailySpendingModel.DailySpendingCategories[0],
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      isSplit: json['isSplit'] ?? false,
      paidy: json['paidy'],
      splits: json['splits'] != null
          ? Split.fromJsonList(json['splits'].cast<Map<String, dynamic>>())
          : null,
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
      'paidy': paidy,
      'splits': splits != null ? Split.toJsonList(splits!) : null,
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
      'assets/expanses_category_icons/ic_$category.png';
}
