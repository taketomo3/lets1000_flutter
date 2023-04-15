import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lets1000_android/database/goal_db.dart';
import 'package:lets1000_android/main.dart';
import 'package:lets1000_android/model/goal.dart';
import 'package:lets1000_android/repository/goal_repository.dart';
import 'package:lets1000_android/state/state.dart';

final settingGoalViewModelProvider =
    StateNotifierProvider<SettingGoalViewModelProvider, MyState>(
  (ref) => SettingGoalViewModelProvider(
    GoalRepository(GoalDatabase()),
  ),
);

class SettingGoalViewModelProvider extends StateNotifier<MyState> {
  SettingGoalViewModelProvider(
    this._goalRepository,
  ) : super(myState);

  final GoalRepository _goalRepository;

  Future<void> addGoal(String goal, String unit) async {
    final g = await _goalRepository.addGoal(
      Goal(
        goal: goal,
        unit: unit,
        createdAt: DateTime.now(),
      ),
    );

    state = state.copyWith(goal: g);
  }

  List<String> toastMessages() {
    return [
      '素敵な目標ですね！',
      'これから頑張りましょう！',
    ];
  }
}
