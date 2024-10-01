class SplitMode {
  final String uid;
  final bool paid;
  final double amount;

  SplitMode({
    required this.uid,
    required this.paid,
    required this.amount,
  });

  Map<String, dynamic> toJSon() {
    return {
      'uid': uid,
      'paid': paid,
      'amount': amount,
    };
  }

  factory SplitMode.fromJSon(Map<String, dynamic> data) {
    return SplitMode(
      uid: data['uid'],
      paid: data['paid'],
      amount: double.parse(data['amount'].toString()),
    );
  }

  SplitMode copyWith({
    String? uid,
    bool? paid,
    double? amount,
  }) {
    return SplitMode(
      uid: uid ?? this.uid,
      paid: paid ?? this.paid,
      amount: amount ?? this.amount,
    );
  }

  static List<SplitMode> fromJsonList(List<dynamic> data) {
    List<SplitMode> SplitModes = [];
    for (var SplitMode in data) {
      SplitModes.add(SplitMode.fromJSon(SplitMode));
    }
    return SplitModes;
  }

  static List<Map<String, dynamic>> toJsonList(List<SplitMode> SplitModes) {
    List<Map<String, dynamic>> data = [];
    for (var SplitMode in SplitModes) {
      data.add(SplitMode.toJSon());
    }
    return data;
  }
}
