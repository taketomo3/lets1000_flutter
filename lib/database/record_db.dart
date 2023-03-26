import 'package:lets1000_android/database/database_helper.dart';

class Record {
  Record({
    required this.id,
    required this.amount,
    required this.date,
    required this.createdAt,
  });

  Record.fromMap(Map<String, dynamic> record)
      : id = record['id'] as int,
        amount = record['amount'] as double,
        date = DateTime.parse(record['date'] as String),
        createdAt = DateTime.parse(record['created_at'] as String);
  final int id;
  final double amount;
  final DateTime date;
  final DateTime createdAt;

  static const String _tableName = 'Record';

  static const executeString = '''
      CREATE TABLE Record (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount REAL NOT NULL,
        date TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
      ''';

  // 全件取得
  static Future<List<Record>> fetchAll() async {
    final db = await DatabaseHelper.instance.database;
    final records = await db!.query(Record._tableName, orderBy: 'id DESC');

    if (records.isEmpty) {
      return [];
    }

    return records.map(Record.fromMap).toList();
  }

  // 追加
  static Future<int> insert(double amount, DateTime date) async {
    final row = <String, dynamic>{
      'amount': amount,
      'date': date.toString(),
      'created_at': DateTime.now().toString()
    };

    final db = await DatabaseHelper.instance.database;
    return db!.insert(Record._tableName, row);
  }

  // 削除
  static Future<int> delete(int id) async {
    final db = await DatabaseHelper.instance.database;
    return db!.delete(Record._tableName, where: 'id = ?', whereArgs: [id]);
  }
}
