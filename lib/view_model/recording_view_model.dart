import 'package:lets1000_android/database/goal_db.dart';
import 'package:lets1000_android/database/record_db.dart';

class RecordingViewModel {
  Goal? goal;

  Future<Goal?> fetchGoal() {
    return Goal.fetchLast();
  }

  void onRegistered(double amount, int dateIndex, void onCreated) {
    final dateList = [
      DateTime.now(),
      DateTime.now().subtract(const Duration(days: 1))
    ];

    Record.insert(amount, dateList[dateIndex]).then((id) => {onCreated});
  }
}
