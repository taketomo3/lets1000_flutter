import 'package:lets1000_android/database/database_helper.dart';

class Record {
  final int id;
  final double amount;
  final DateTime date;
  final DateTime createdAt;

  static const String _tableName = 'Record';

  Record(
      {required this.id,
      required this.amount,
      required this.date,
      required this.createdAt});

  static const executeString = '''
      CREATE TABLE Record (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount REAL NOT NULL,
        date TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
      ''';

  static Record fromMap(Map<String, dynamic> record) {
    return Record(
        id: record['id'] as int,
        amount: record['amount'] as double,
        date: DateTime.parse(record['date'] as String),
        createdAt: DateTime.parse(record['created_at'] as String));
  }

  // 全件取得
  static Future<List<Record>> fetchAll() async {
    final db = await DatabaseHelper.instance.database;
    final records = await db!.query(Record._tableName, orderBy: 'id DESC');

    if (records.isEmpty) {
      return [];
    }

    return records.map((record) => Record.fromMap(record)).toList();
  }

  // 追加
  static Future<int> insert(double amount, DateTime date) async {
    Map<String, dynamic> row = {
      'amount': amount,
      'date': date.toString(),
      'created_at': DateTime.now().toString()
    };

    final db = await DatabaseHelper.instance.database;
    return await db!.insert(Record._tableName, row);
  }

  // 削除
  static Future<int> delete(int id) async {
    final db = await DatabaseHelper.instance.database;
    return await db!
        .delete(Record._tableName, where: 'id = ?', whereArgs: [id]);
  }
}
