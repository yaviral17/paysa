class UserSplitModel {
  final String uid;
  final String amount;
  final List<String> tokens;
  final bool isPaid;
  final String createdAt;
  final String paidAt;

  UserSplitModel({
    required this.uid,
    required this.amount,
    required this.tokens,
    required this.isPaid,
    required this.createdAt,
    required this.paidAt,
  });

  factory UserSplitModel.fromJson(Map<String, dynamic> json) {
    return UserSplitModel(
      uid: json['uid'],
      amount: json['amount'],
      tokens: List<String>.from(json['tokens']),
      isPaid: json['isPaid'],
      createdAt: json['createdAt'],
      paidAt: json['paidAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'amount': amount,
      'tokens': tokens,
      'isPaid': isPaid,
      'createdAt': createdAt,
      'paidAt': paidAt,
    };
  }
}
