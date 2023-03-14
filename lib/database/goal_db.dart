import 'package:lets1000_android/database/database_helper.dart';

class Goal {
  final int id;
  final String goal;
  final String unit;
  final DateTime createdAt;

  static const String _tableName = 'Goal';

  Goal(
      {required this.id,
      required this.goal,
      required this.unit,
      required this.createdAt});

  static const executeString = '''
      CREATE TABLE Goal (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        goal TEXT NOT NULL,
        unit TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
      ''';

  static Future<Goal?> fetchLast() async {
    final db = await DatabaseHelper.instance.database;
    final goals =
        await db!.query(Goal._tableName, orderBy: 'id DESC', limit: 1);

    if (goals.isEmpty) {
      return null;
    }

    final goal = goals.first;

    return Goal(
        id: goal['id'] as int,
        goal: goal['goal'] as String,
        unit: goal['unit'] as String,
        createdAt: DateTime.parse(goal['created_at'] as String));
  }

  static Future<int> insert(String goal, String unit) async {
    Map<String, dynamic> row = {
      'goal': goal,
      'unit': unit,
      'created_at': DateTime.now().toString()
    };

    final db = await DatabaseHelper.instance.database;
    return await db!.insert(Goal._tableName, row);
  }
}
