class TransferSpendingModel {
  final String message;
  final String amount;
  final DateTime dateTime;
  final String? billImage;
  final String? location;
  final String transferedTo;
  final String transferedFrom;

  TransferSpendingModel({
    required this.message,
    required this.amount,
    required this.dateTime,
    this.billImage,
    this.location,
    required this.transferedTo,
    required this.transferedFrom,
  });

  factory TransferSpendingModel.fromJson(Map<String, dynamic> json) {
    return TransferSpendingModel(
      message: json['message'],
      amount: json['amount'],
      dateTime: DateTime.parse(json['dateTime']),
      billImage: json['billImage'],
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
      'billImage': billImage,
      'location': location,
      'transferedTo': transferedTo,
      'transferedFrom': transferedFrom,
    };
  }
}
