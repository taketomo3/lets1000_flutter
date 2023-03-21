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

  fetchRecordList() {
    Record.fetchAll().then((value) {
      recordList = value;
      _recordListController.add(value);
    });
  }

  Future<Goal?> fetchGoal() {
    return Goal.fetchLast();
  }

  int fetchMonthlyTotal(String dateString) {
    List<String> dateParts = dateString.split("年");
    int year = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1].split("月")[0]);

    double total = 0;

    recordList?.forEach((record) {
      if (record.date.year == year && record.date.month == month) {
        total += record.amount;
      }
    });

    return total.toInt();
  }
}
