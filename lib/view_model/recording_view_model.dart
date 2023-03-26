import 'package:lets1000_android/database/goal_db.dart';
import 'package:lets1000_android/database/record_db.dart';

class RecordingViewModel {
  Goal? goal;

  Future<Goal?> fetchGoal() {
    return Goal.fetchLast();
  }

  Future<void> onRegistered(
    double amount,
    int dateIndex,
    void onCreated,
  ) async {
    final dateList = [
      DateTime.now(),
      DateTime.now().subtract(const Duration(days: 1))
    ];

    final _ = await Record.insert(amount, dateList[dateIndex]);
    return onCreated;
  }
}
