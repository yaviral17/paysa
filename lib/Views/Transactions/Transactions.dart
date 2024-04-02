class Transaction {
  final String id;
  final double amount;
  final String splitName;
  final String description;
  final String paidBy;
  final String createdBy;
  final String createdByUserName;
  final bool isSettled;
  final bool isChat;
  final DateTime timestamp;

  /*
    {
      uid: "user_id",
      paid: bool,

    }
   */

  final List<Map<String, dynamic>> members;

  Transaction({
    required this.id,
    required this.amount,
    required this.description,
    required this.paidBy,
    required this.members,
    required this.createdBy,
    required this.createdByUserName,
    required this.isSettled,
    this.isChat = false,
    required this.splitName,
    required this.timestamp,
  });

  Map<String, dynamic> toJSon() {
    return {
      'id': id,
      'amount': amount,
      'splitName': splitName,
      'description': description,
      'paidBy': paidBy,
      'members': members,
      'createdBy': createdBy,
      'createdByUserName': createdByUserName,
      'isSettled': isSettled,
      'isChat': isChat,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory Transaction.fromJSon(Map<String, dynamic> data) {
    return Transaction(
      id: data['id'],
      amount: double.parse(data['amount'].toString()),
      splitName: data['splitName'],
      description: data['description'],
      paidBy: data['paidBy'],
      members: List<Map<String, dynamic>>.from(data['members']),
      createdBy: data['createdBy'],
      createdByUserName: data['createdByUserName'],
      isSettled: data['isSettled'],
      isChat: data['isChat'],
      timestamp: DateTime.parse(data['timestamp']),
    );
  }
}
