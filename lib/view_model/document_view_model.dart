import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lets1000_android/state/state.dart';
import 'package:lets1000_android/view_model/my_state_view_model.dart';
import 'package:package_info_plus/package_info_plus.dart';

final documentViewModelProvider =
    StateNotifierProvider<DocumentViewModelProvider, MyState>(
  (ref) => DocumentViewModelProvider(ref.watch(myStateProvider.notifier)),
);

class DocumentViewModelProvider extends StateNotifier<MyState> {
  DocumentViewModelProvider(
    MyStateNotifier myStateNotifier,
  ) : super(myStateNotifier.state) {
    _myStateNotifier = myStateNotifier;
  }

  MyStateNotifier? _myStateNotifier;

  double fetchAverageAmount() {
    final state = _myStateNotifier?.state;
    if (state == null || state.totalRecordAmount == 0) {
      return 0;
    }

    final average = state.totalRecordAmount / state.recordList.length;
    return (average * 10).toInt() / 10;
  }

  int fetchExpectedTotalAmount() {
    final state = _myStateNotifier?.state;
    if (state == null || state.totalRecordAmount == 0) {
      return 0;
    }

    final startDate = DateTime(2023);
    final today = DateTime.now();

    final daysSinceStart = today.difference(startDate).inDays;
    const totalDaysInYear = 365;

    final expectedTotalAmount =
        (totalDaysInYear / daysSinceStart) * state.totalRecordAmount;
    return expectedTotalAmount.toInt();
  }

  final packageInfoProvider = FutureProvider<PackageInfo>((ref) {
    return PackageInfo.fromPlatform();
  });
}
