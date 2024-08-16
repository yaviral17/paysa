class Transaction {
  final String id;
  final String emoji;
  final String title;
  final String subtitle;
  final double amount;
  final DateTime createdAt;
  final String paidBy;

  Transaction({
    required this.id,
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.createdAt,
    required this.paidBy,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      emoji: json['emoji'],
      title: json['title'],
      subtitle: json['subtitle'],
      amount: json['amount'],
      createdAt: DateTime.parse(json['createdAt']),
      paidBy: json['paidBy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'emoji': emoji,
      'title': title,
      'subtitle': subtitle,
      'amount': amount,
      'createdAt': createdAt.toIso8601String(),
      'paidBy': paidBy,
    };
  }
}
