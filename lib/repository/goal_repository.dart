import 'package:lets1000_android/database/goal_db.dart';
import 'package:lets1000_android/model/goal.dart';

class GoalRepository {
  GoalRepository(this._goalDatabase);

  final GoalDatabase _goalDatabase;

  Future<Goal?> fetchGoal() async {
    return _goalDatabase.fetchGoal();
  }

  Future<Goal> addGoal(Goal goal) async {
    return _goalDatabase.insert(goal);
  }
}
