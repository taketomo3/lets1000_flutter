import 'package:lets1000_android/database_helper.dart';

class Goal {
  final int? id = null;
  final String goal;
  final String unit;
  final DateTime createdAt = DateTime.now();

  Goal({required this.goal, required this.unit});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'goal': goal,
      'unit': unit,
      'created_at': createdAt,
    };
  }

  static const executeString = '''
      CREATE TABLE Goal (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        goal TEXT NOT NULL,
        unit TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
      ''';

  void insert() async {
    Map<String, dynamic> row = {
      'goal': goal,
      'unit': unit,
      'created_at': createdAt.toString()
    };
    final id = await DatabaseHelper.instance.insert('Goal', row);
    print('登録しました $id');
  }
}
