import 'package:lets1000_android/database_helper.dart';

class Record {
  final int? id = null;
  final double amount;
  final DateTime date;
  final DateTime createdAt = DateTime.now();

  Record({required this.amount, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'date': date,
      'created_at': createdAt,
    };
  }

  static const executeString = '''
      CREATE TABLE Record (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount REAL NOT NULL,
        date TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
      ''';

  void insert() async {
    Map<String, dynamic> row = {
      'amount': amount,
      'date': date.toString(),
      'created_at': createdAt.toString()
    };
    final id = await DatabaseHelper.instance.insert('Record', row);
    print('登録しました $id');
  }
}
