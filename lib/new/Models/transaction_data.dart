class Transaction {
  final String id;
  final String createdBy;
  final String paidBy;
  final List<String> usersInvolved;
  final String title;
  final String category;
  final double amount;
  final DateTime createdAt;

  Transaction({
    required this.id,
    required this.createdBy,
    required this.paidBy,
    required this.usersInvolved,
    required this.title,
    required this.category,
    required this.amount,
    required this.createdAt,
  });
}
