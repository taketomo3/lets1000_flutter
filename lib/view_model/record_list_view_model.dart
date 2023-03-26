import 'dart:async';

import 'package:lets1000_android/database/goal_db.dart';
import 'package:lets1000_android/database/record_db.dart';

class RecordListViewModel {
  RecordListViewModel() {
    fetchRecordList();
  }

  List<Record>? recordList;

  final _recordListController = StreamController<List<Record>?>.broadcast();

  Stream<List<Record>?> get recordListStream => _recordListController.stream;

  void dispose() {
    _recordListController.close();
  }

  void fetchRecordList() {
    Record.fetchAll().then((value) {
      recordList = value;
      _recordListController.add(value);
    });
  }

  Future<Goal?> fetchGoal() {
    return Goal.fetchLast();
  }

  int fetchMonthlyTotal(String dateString) {
    final dateParts = dateString.split('年');
    final year = int.parse(dateParts[0]);
    final month = int.parse(dateParts[1].split('月')[0]);

    var total = 0.0;

    recordList?.forEach((record) {
      if (record.date.year == year && record.date.month == month) {
        total += record.amount;
      }
    });

    return total.toInt();
  }
}
