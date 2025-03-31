import 'package:paysa/Models/user_model.dart';

class UserSplitModel {
  final String uid;
  String amount;
  final String? token;
  final bool isPaid;
  final String createdAt;
  final String? paidAt;
  UserModel? user;

  UserSplitModel({
    required this.uid,
    required this.amount,
    required this.token,
    required this.isPaid,
    required this.createdAt,
    this.paidAt,
    this.user,
  });

  factory UserSplitModel.fromJson(Map<String, dynamic> json) {
    return UserSplitModel(
      uid: json['uid'],
      amount: json['amount'],
      token: json['token'],
      isPaid: json['isPaid'],
      createdAt: json['createdAt'],
      paidAt: json['paidAt'],
      user: json['user'] != null ? UserModel.fromMap(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'amount': amount,
      'tokens': token,
      'isPaid': isPaid,
      'createdAt': createdAt,
      'paidAt': paidAt,
      'user': user?.toMap(),
    };
  }
}
