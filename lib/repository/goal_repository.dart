import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lets1000_android/database/goal_db.dart';

final asyncGoalProvider = FutureProvider<Goal?>((ref) async {
  return Goal.fetchLast();
});

final goalProvider = Provider<Goal?>((ref) {
  final goal = ref.watch(asyncGoalProvider);
  return goal.value;
});
