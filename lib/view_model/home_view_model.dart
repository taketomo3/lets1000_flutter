import 'dart:async';

import 'package:lets1000_android/database/goal_db.dart';
import 'package:lets1000_android/database/record_db.dart';

class HomeViewModel {
  HomeViewModel() {
    fetchTotalAmount();
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

  fetchTotalAmount() {
    Record.fetchAll().then((value) {
      double amount = 0;
      for (var e in value) {
        amount += e.amount;
      }
      totalAmount = amount.toInt();
      _totalAmountController.add(totalAmount);
    });
  }

  fetchGoal() {
    Goal.fetchLast().then((value) {
      goal = value;
      _hasGoalController.add(value != null);
    });
  }
}
