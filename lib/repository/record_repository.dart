import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lets1000_android/database/record_db.dart';

final recordListProvider = FutureProvider<List<Record>>((ref) async {
  return Record.fetchAll();
});

final totalAmountProvider = FutureProvider<int>((ref) async {
  final list = ref.watch(recordListProvider).requireValue;

  final amount = list
      .fold<double>(
        0,
        (previousValue, element) => previousValue + element.amount,
      )
      .toInt();

  return amount;
});
