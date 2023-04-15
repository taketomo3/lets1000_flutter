import 'package:lets1000_android/database/app_database.dart';
import 'package:lets1000_android/model/goal.dart';

class GoalDatabase extends AppDatabase {
  static const String _tableName = 'Goal';

  Future<Goal?> fetchGoal() async {
    final db = await database;
    final maps = await db.query(
      _tableName,
      orderBy: 'id DESC',
      limit: 1,
    );

    if (maps.isEmpty) {
      return null;
    }

    return Goal.fromJson(maps.first);
  }

  Future<Goal> insert(Goal goal) async {
    final db = await database;

    final id = await db.insert(
      _tableName,
      goal.toJson(),
    );

    return goal.copyWith(
      id: id,
    );
  }
}
