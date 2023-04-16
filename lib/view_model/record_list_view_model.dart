import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lets1000_android/state/state.dart';
import 'package:lets1000_android/view_model/my_state_view_model.dart';

final recordListViewModelProvider =
    StateNotifierProvider<RecordListViewModelProvider, MyState>(
  (ref) => RecordListViewModelProvider(ref.watch(myStateProvider.notifier)),
);

class RecordListViewModelProvider extends StateNotifier<MyState> {
  RecordListViewModelProvider(
    MyStateNotifier myStateNotifier,
  ) : super(myStateNotifier.state) {
    _myStateNotifier = myStateNotifier;
  }

  MyStateNotifier? _myStateNotifier;

  int fetchMonthlyTotal(String dateString) {
    final recordList = _myStateNotifier?.state.recordList;

    if (recordList == null) {
      return 0;
    }

    final dateParts = dateString.split('年');
    final year = int.parse(dateParts[0]);
    final month = int.parse(dateParts[1].split('月')[0]);

    var total = 0.0;
    for (final record in recordList) {
      if (record.date.year == year && record.date.month == month) {
        total += record.amount;
      }
    }

    return total.toInt();
  }
}
