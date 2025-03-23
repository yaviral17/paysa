import 'package:firebase_auth/firebase_auth.dart';
import 'package:paysa/Controllers/authentication_controller.dart';
import 'package:paysa/Models/user_model.dart';

class TransferSpendingModel {
  final String message;
  final String amount;
  final DateTime dateTime;
  final String? location;
  final String transferedTo;
  final String transferedFrom;
  UserModel? transferdToUser;
  UserModel? transferdFromUser;

  TransferSpendingModel({
    required this.message,
    required this.amount,
    required this.dateTime,
    this.location,
    required this.transferedTo,
    required this.transferedFrom,
    this.transferdToUser,
    this.transferdFromUser,
  });

  factory TransferSpendingModel.fromJson(Map<String, dynamic> json) {
    bool isMe = json['transferedTo'] == FirebaseAuth.instance.currentUser!.uid;

    return TransferSpendingModel(
      message: json['message'],
      amount: json['amount'],
      dateTime: DateTime.parse(json['dateTime']),
      location: json['location'],
      transferedTo: json['transferedTo'],
      transferedFrom: json['transferedFrom'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'amount': amount,
      'dateTime': dateTime.toIso8601String(),
      'location': location,
      'transferedTo': transferedTo,
      'transferedFrom': transferedFrom,
    };
  }
}
