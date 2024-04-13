import 'package:paysa/Models/DailySpendingModel.dart';
import 'package:paysa/Models/UserModel.dart';

class SplitSession {
  String id;
  List<UserModel> members;
  DailySpendingModel dailySpending;
  SplitSession({
    required this.id,
    required this.members,
    required this.dailySpending,
  });
}
