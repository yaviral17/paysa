
// spending type enum
enum SpendingType { shopping, transfer, split, income, other }

extension SpendingTypeExtension on SpendingType {
  String get value {
    switch (this) {
      case SpendingType.shopping:
        return "Shopping";
      case SpendingType.transfer:
        return "Transfer";
      case SpendingType.split:
        return "Split";
      case SpendingType.income:
        return "Income";
      default:
        return "Other";
    }
  }

  static SpendingType fromString(String value) {
    switch (value) {
      case "Shopping":
        return SpendingType.shopping;
      case "Transfer":
        return SpendingType.transfer;
      case "Split":
        return SpendingType.split;
      case "Income":
        return SpendingType.income;
      default:
        return SpendingType.other;
    }
  }
}
