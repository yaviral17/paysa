class Transaction {
  final String id;
  final String title;
  final String category;
  final double amount;
  final DateTime date;

  Transaction({
    required this.id,
    required this.title,
    required this.category,
    required this.amount,
    required this.date,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }
}
