import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lets1000_android/database/goal_db.dart';
import 'package:lets1000_android/database/record_db.dart';
import 'package:lets1000_android/model/goal.dart';
import 'package:lets1000_android/model/record.dart';
import 'package:lets1000_android/repository/goal_repository.dart';
import 'package:lets1000_android/repository/record_repository.dart';
import 'package:lets1000_android/state/state.dart';

final myStateProvider = StateNotifierProvider<MyStateNotifier, MyState>((ref) {
  return MyStateNotifier(const MyState());
});

class MyStateNotifier extends StateNotifier<MyState> {
  MyStateNotifier(super.state) {
    fetchGoal();
    fetchRecordList();
    fetchTotalRecordAmount();
  }

  final GoalRepository _goalRepository = GoalRepository(GoalDatabase());
  final RecordRepository _recordRepository = RecordRepository(RecordDatabase());

  Future<void> fetchGoal() async {
    final goal = await _goalRepository.fetchGoal();
    state = state.copyWith(goal: goal);
  }

  Future<void> fetchRecordList() async {
    final recordList = await _recordRepository.fetchRecordList();
    state = state.copyWith(recordList: recordList);
  }

  Future<void> fetchTotalRecordAmount() async {
    final recordList = await _recordRepository.fetchRecordList();

    final total = recordList.fold<double>(
      0,
      (sum, record) => sum + record.amount,
    );

    state = state.copyWith(totalRecordAmount: total.toInt());
  }

  void updateMyState(Goal? goal, Record? record) {
    final totalAmount = state.totalRecordAmount + (record?.amount ?? 0);
    final newRecordList =
        record != null ? [...state.recordList, record] : state.recordList;

    final newState = state.copyWith(
      goal: goal ?? state.goal,
      totalRecordAmount: totalAmount.toInt(),
      recordList: newRecordList,
    );

    state = newState;
  }
}
