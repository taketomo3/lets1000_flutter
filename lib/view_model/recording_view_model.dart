import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lets1000_android/database/record_db.dart';
import 'package:lets1000_android/model/record.dart';
import 'package:lets1000_android/repository/record_repository.dart';
import 'package:lets1000_android/state/state.dart';
import 'package:lets1000_android/view_model/my_state_view_model.dart';

final recordingViewModelProvider =
    StateNotifierProvider<RecordingViewModelProvider, MyState>(
  (ref) => RecordingViewModelProvider(
    ref.watch(myStateProvider.notifier),
  ),
);

class RecordingViewModelProvider extends StateNotifier<MyState> {
  RecordingViewModelProvider(
    MyStateNotifier myStateNotifier,
  ) : super(myStateNotifier.state) {
    _myStateNotifier = myStateNotifier;
  }

  MyStateNotifier? _myStateNotifier;
  final RecordRepository _recordRepository = RecordRepository(RecordDatabase());

  Future<Record> insertRecord(double amount, int dateIndex) async {
    final date = fetchDateFromIndex(dateIndex);
    final record = await _recordRepository.addRecord(
      Record(
        amount: amount,
        date: date,
        createdAt: DateTime.now(),
      ),
    );

    _myStateNotifier?.updateMyState(null, record);
    return record;
  }

  DateTime fetchDateFromIndex(int index) {
    final dateList = [
      DateTime.now(),
      DateTime.now().subtract(const Duration(days: 1))
    ];
    return dateList[index];
  }

  List<String> toastMessages() {
    return [
      'ナイス！！',
      'お疲れ様です！！',
      'いい調子ですね！',
      '！！！！',
      '記録しました！',
    ];
  }
}
