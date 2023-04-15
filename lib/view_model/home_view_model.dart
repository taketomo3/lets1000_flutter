import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lets1000_android/database/goal_db.dart';
import 'package:lets1000_android/database/record_db.dart';
import 'package:lets1000_android/main.dart';
import 'package:lets1000_android/repository/goal_repository.dart';
import 'package:lets1000_android/repository/record_repository.dart';
import 'package:lets1000_android/state/state.dart';

final homeViewModelProvider =
    StateNotifierProvider<HomeViewModelProvider, MyState>(
  (ref) => HomeViewModelProvider(
    GoalRepository(GoalDatabase()),
    RecordRepository(RecordDatabase()),
  ),
);

class HomeViewModelProvider extends StateNotifier<MyState> {
  HomeViewModelProvider(
    this._goalRepository,
    this._recordRepository,
  ) : super(myState) {
    fetchGoal();
    fetchTotalRecordAmount();
  }

  final GoalRepository _goalRepository;
  final RecordRepository _recordRepository;

  Future<void> fetchGoal() async {
    final goal = await _goalRepository.fetchGoal();

    state = state.copyWith(goal: goal);
  }

  Future<void> fetchTotalRecordAmount() async {
    final record = await _recordRepository.fetchRecordList();

    var total = 0.0;
    for (final r in record) {
      total += r.amount;
    }

    state = state.copyWith(totalRecordAmount: total.toInt());
  }
}
