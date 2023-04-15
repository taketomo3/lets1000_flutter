import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lets1000_android/database/goal_db.dart';
import 'package:lets1000_android/database/record_db.dart';
import 'package:lets1000_android/main.dart';
import 'package:lets1000_android/model/record.dart';
import 'package:lets1000_android/repository/goal_repository.dart';
import 'package:lets1000_android/repository/record_repository.dart';
import 'package:lets1000_android/state/state.dart';

final recordingViewModelProvider =
    StateNotifierProvider<RecordingViewModelProvider, MyState>(
  (ref) => RecordingViewModelProvider(
    GoalRepository(GoalDatabase()),
    RecordRepository(RecordDatabase()),
  ),
);

class RecordingViewModelProvider extends StateNotifier<MyState> {
  RecordingViewModelProvider(
    this._goalRepository,
    this._recordRepository,
  ) : super(myState) {
    fetchGoal();
  }

  final GoalRepository _goalRepository;
  final RecordRepository _recordRepository;

  Future<void> fetchGoal() async {
    final goal = await _goalRepository.fetchGoal();
    state = state.copyWith(goal: goal);
  }

  Future<Record> insertRecord(double amount, int dateIndex) async {
    final date = fetchDateFromIndex(dateIndex);
    final record = await _recordRepository.addRecord(
      Record(
        amount: amount,
        date: date,
        createdAt: DateTime.now(),
      ),
    );

    state = state.copyWith(
      totalRecordAmount: state.totalRecordAmount + amount.toInt(),
    );

    return record;
  }

  DateTime fetchDateFromIndex(int index) {
    final dateList = [
      DateTime.now(),
      DateTime.now().subtract(const Duration(days: 1))
    ];
    return dateList[index];
  }

  List<String> toastMessages() {
    return [
      'ナイス！！',
      'お疲れ様です！！',
      'いい調子ですね！',
      '！！！！',
      '記録しました！',
    ];
  }
}
