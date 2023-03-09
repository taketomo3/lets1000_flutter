import 'package:lets1000_android/database_helper.dart';

class Goal {
  final int id;
  final String goal;
  final String unit;
  final DateTime createdAt;

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

  static Future fetchLast() async {
    final db = await DatabaseHelper.instance.database;
    final goals = await db!.query('Goal', orderBy: 'id DESC', limit: 1);

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

  static void insert(goal, unit) async {
    Map<String, dynamic> row = {
      'goal': goal,
      'unit': unit,
      'created_at': DateTime.now().toString()
    };

    final db = await DatabaseHelper.instance.database;
    final id = await db!.insert('Goal', row);
    // print('登録しました goal $id');
  }
}
