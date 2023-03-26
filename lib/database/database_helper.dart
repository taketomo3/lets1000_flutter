import 'package:lets1000_android/database/goal_db.dart';
import 'package:lets1000_android/database/record_db.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static const _databaseName = 'lets1000.db';
  static const _databaseVersion = 1;

  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    return _database = await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);

    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(Goal.executeString);
    await db.execute(Record.executeString);
  }
}
