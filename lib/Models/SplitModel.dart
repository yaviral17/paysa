class Split {
  final String uid;
  final bool paid;
  final double amount;
  final bool urgent;

  Split({
    required this.uid,
    required this.paid,
    required this.amount,
    required this.urgent,
  });

  Map<String, dynamic> toJSon() {
    return {
      'uid': uid,
      'paid': paid,
      'amount': amount,
      'urgent': urgent,
    };
  }

  factory Split.fromJSon(Map<String, dynamic> data) {
    return Split(
      uid: data['uid'],
      paid: data['paid'],
      amount: double.parse(data['amount'].toString()),
      urgent: data['urgent'],
    );
  }

  Split copyWith({
    String? uid,
    bool? paid,
    double? amount,
    bool? urgent,
  }) {
    return Split(
      uid: uid ?? this.uid,
      paid: paid ?? this.paid,
      amount: amount ?? this.amount,
      urgent: urgent ?? this.urgent,
    );
  }

  static List<Split> fromJsonList(List<dynamic> data) {
    List<Split> splits = [];
    for (var split in data) {
      splits.add(Split.fromJSon(split));
    }
    return splits;
  }

  static List<Map<String, dynamic>> toJsonList(List<Split> splits) {
    List<Map<String, dynamic>> data = [];
    for (var split in splits) {
      data.add(split.toJSon());
    }
    return data;
  }
}
