import 'package:lets1000_android/database/app_database.dart';
import 'package:lets1000_android/model/record.dart';

class RecordDatabase extends AppDatabase {
  static const String _tableName = 'Record';

  Future<List<Record>> fetchRecordList() async {
    final db = await database;
    final maps = await db.query(
      _tableName,
      orderBy: 'id DESC',
    );

    if (maps.isEmpty) {
      return [];
    }

    return maps.map(Record.fromJson).toList();
  }

  Future<Record> insert(Record record) async {
    final db = await database;

    final id = await db.insert(
      _tableName,
      record.toJson(),
    );

    return record.copyWith(
      id: id,
    );
  }

  Future<void> delete(int id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
