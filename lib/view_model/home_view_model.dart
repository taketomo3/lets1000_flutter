import 'dart:async';

import 'package:lets1000_android/database/goal_db.dart';
import 'package:lets1000_android/database/record_db.dart';

class HomeViewModel {
  HomeViewModel() {
    Future(() async {
      await fetchTotalAmount();
    });
    fetchGoal();
  }

  int? totalAmount;
  Goal? goal;
  bool? hasGoal;

  final _totalAmountController = StreamController<int?>.broadcast();
  final _hasGoalController = StreamController<bool?>.broadcast();

  Stream<int?> get totalAmountStream => _totalAmountController.stream;
  Stream<bool?> get hasGoalStream => _hasGoalController.stream;

  void dispose() {
    _totalAmountController.close();
    _hasGoalController.close();
  }

  Future<void> fetchTotalAmount() async {
    final value = await Record.fetchAll();
    var amount = 0.0;
    for (final e in value) {
      amount += e.amount;
    }
    totalAmount = amount.toInt();
    _totalAmountController.add(totalAmount);
  }

  Future<void> fetchGoal() async {
    final value = await Goal.fetchLast();
    goal = value;
    _hasGoalController.add(value != null);
  }
}
