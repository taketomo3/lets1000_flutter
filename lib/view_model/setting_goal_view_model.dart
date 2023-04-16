import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lets1000_android/database/goal_db.dart';
import 'package:lets1000_android/model/goal.dart';
import 'package:lets1000_android/repository/goal_repository.dart';
import 'package:lets1000_android/state/state.dart';
import 'package:lets1000_android/view_model/my_state_view_model.dart';

final settingGoalViewModelProvider =
    StateNotifierProvider<SettingGoalViewModelProvider, MyState>(
  (ref) => SettingGoalViewModelProvider(
    ref.watch(myStateProvider.notifier),
  ),
);

class SettingGoalViewModelProvider extends StateNotifier<MyState> {
  SettingGoalViewModelProvider(
    MyStateNotifier myStateNotifier,
  ) : super(myStateNotifier.state) {
    _myStateNotifier = myStateNotifier;
  }

  MyStateNotifier? _myStateNotifier;
  final _goalRepository = GoalRepository(GoalDatabase());

  Future<void> addGoal(String goal, String unit) async {
    final g = await _goalRepository.addGoal(
      Goal(
        goal: goal,
        unit: unit,
        createdAt: DateTime.now(),
      ),
    );

    _myStateNotifier?.updateMyState(g, null);
  }

  List<String> toastMessages() {
    return [
      '素敵な目標ですね！',
      'これから頑張りましょう！',
    ];
  }
}
