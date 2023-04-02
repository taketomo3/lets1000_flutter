import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lets1000_android/database/record_db.dart';

final asyncRecordListProvider = FutureProvider<List<Record>>((ref) async {
  return Record.fetchAll();
});

final recordListProvider = Provider<List<Record>>((ref) {
  final list = ref.watch(asyncRecordListProvider);
  return list.value ?? [];
});

final totalAmountProvider = Provider<int>((ref) {
  final amount = ref
      .watch(recordListProvider)
      .fold<double>(
        0,
        (previousValue, element) => previousValue + element.amount,
      )
      .toInt();

  return amount;
});

final totalRecordCountProvider =
    Provider<int>((ref) => ref.watch(recordListProvider).length);

final averageAmountProvider = Provider<double>((ref) {
  final totalCount = ref.watch(totalRecordCountProvider);

  if (totalCount == 0) {
    return 0;
  }

  final average = ref.watch(totalAmountProvider) / totalCount;
  return (average * 10).toInt() / 10;
});

final expectedTotalAmountProvider = Provider<int>((ref) {
  final totalAmount = ref.watch(totalAmountProvider);
  if (totalAmount == 0) {
    return 0;
  }

  final startDate = DateTime(2023);
  final today = DateTime.now();

  final daysSinceStart = today.difference(startDate).inDays;
  const totalDaysInYear = 365;

  final expectedTotalAmount = (totalDaysInYear / daysSinceStart) * totalAmount;
  return expectedTotalAmount.toInt();
});
