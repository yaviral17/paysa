class ShoppingModel {
  final String message;
  final String amount;
  final DateTime dateTime;
  final String? location;
  final String? category;

  ShoppingModel({
    required this.message,
    required this.amount,
    required this.dateTime,
    this.location,
    this.category,
  });

  factory ShoppingModel.fromJson(Map<String, dynamic> json) {
    return ShoppingModel(
      message: json['message'],
      amount: json['amount'],
      dateTime: DateTime.parse(json['dateTime']),
      location: json['location'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'amount': amount,
      'dateTime': dateTime.toIso8601String(),
      'location': location,
      'category': category,
    };
  }
}
