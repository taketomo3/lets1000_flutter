import 'package:lets1000_android/database_helper.dart';

class Record {
  final int id;
  final double amount;
  final DateTime date;
  final DateTime createdAt;

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

  static void insert(amount, date) async {
    Map<String, dynamic> row = {
      'amount': amount,
      'date': date.toString(),
      'created_at': DateTime.now().toString()
    };

    final db = await DatabaseHelper.instance.database;
    final id = await db!.insert('Record', row);
    print('登録しました record $id');
  }
}
