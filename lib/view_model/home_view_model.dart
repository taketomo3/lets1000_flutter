import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lets1000_android/database/goal_db.dart';

class GoalNotifier extends StateNotifier<Goal?> {
  GoalNotifier() : super(null);

  void addGoal(Goal goal) {
    state = goal;
  }

  void update() async {
    state = await Goal.fetchLast();
  }
}

final goalProvider = StateNotifierProvider<GoalNotifier, Goal?>((ref) {
  var notifier = GoalNotifier();
  notifier.update();
  return notifier;
});
