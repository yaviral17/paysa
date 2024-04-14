import 'package:paysa/Models/SplitModel.dart';

class DailySpendingSplitModel {
  final String id;
  final DateTime createdOn;
  final double amount;
  final String paidBy;
  final List<Split> splits;

  DailySpendingSplitModel({
    required this.id,
    required this.createdOn,
    required this.amount,
    required this.paidBy,
    this.splits = const [],
  });

  factory DailySpendingSplitModel.fromJson(Map<String, dynamic> json) {
    return DailySpendingSplitModel(
      id: json['id'],
      createdOn: DateTime.parse(json['createdOn']),
      amount: double.parse(json['amount'].toString()),
      paidBy: json['paidBy'],
      splits: json['splits'] == null ? [] : Split.fromJsonList(json['splits']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdOn': createdOn.toIso8601String(),
      'amount': amount,
      'paidBy': paidBy,
      'splits': Split.toJsonList(splits),
    };
  }

  static List<DailySpendingSplitModel> fromJsonList(
      List<Map<String, dynamic>> json) {
    List<DailySpendingSplitModel> result = [];
    for (Map<String, dynamic> item in json) {
      result.add(DailySpendingSplitModel.fromJson(item));
    }
    return result;
  }

  static List<Map<String, dynamic>> toJsonList(
      List<DailySpendingSplitModel> dailySpendings) {
    List<Map<String, dynamic>> data = [];
    for (var dailySpending in dailySpendings) {
      data.add(dailySpending.toJson());
    }
    return data;
  }
}
