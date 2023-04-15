import 'package:lets1000_android/database/record_db.dart';
import 'package:lets1000_android/model/record.dart';

class RecordRepository {
  RecordRepository(this._recordDatabase);

  final RecordDatabase _recordDatabase;

  Future<List<Record>> fetchRecordList() async {
    return _recordDatabase.fetchRecordList();
  }

  Future<Record> addRecord(Record record) async {
    return _recordDatabase.insert(record);
  }

  Future<void> deleteRecord(int id) async {
    return _recordDatabase.delete(id);
  }
}
