class Transaction {
  final String id;
  final double amount;
  final String description;
  final String paidBy;
  final String createdBy;
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
    required this.isSettled,
    this.isChat = false,
    required this.timestamp,
  });

  Map<String, dynamic> toJSon() {
    return {
      'id': id,
      'amount': amount,
      'description': description,
      'paidBy': paidBy,
      'members': members,
      'createdBy': createdBy,
      'isSettled': isSettled,
      'isChat': isChat,
      'timestamp': timestamp,
    };
  }

  factory Transaction.fromJSon(Map<String, dynamic> data) {
    return Transaction(
      id: data['id'],
      amount: data['amount'],
      description: data['description'],
      paidBy: data['paidBy'],
      members: List<Map<String, dynamic>>.from(data['members']),
      createdBy: data['createdBy'],
      isSettled: data['isSettled'],
      isChat: data['isChat'],
      timestamp: data['timestamp'],
    );
  }
}
