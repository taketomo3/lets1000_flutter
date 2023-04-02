import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:lets1000_android/database/goal_db.dart';
import 'package:lets1000_android/database/record_db.dart';
import 'package:lets1000_android/repository/goal_repository.dart';
import 'package:lets1000_android/repository/record_repository.dart';
import 'package:lets1000_android/view/common/error_view.dart';

class RecordListView extends ConsumerStatefulWidget {
  const RecordListView({super.key});

  @override
  RecordListViewState createState() => RecordListViewState();
}

class RecordListViewState extends ConsumerState<RecordListView> {
  late final Goal? goal = ref.watch(goalProvider);

  @override
  Widget build(BuildContext context) {
    final recordList = ref.watch(asyncRecordListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('頑張った記録')),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        color: Colors.blueGrey[50],
        child: recordList.when(
          loading: () => const LinearProgressIndicator(),
          error: (error, _) => errorView(error),
          data: (recordList) => (goal == null || recordList.isEmpty)
              ? noRecordView()
              : GroupedListView(
                  elements: recordList,
                  groupBy: (record) =>
                      '${record.date.year}年 ${record.date.month}月',
                  order: GroupedListOrder.DESC,
                  itemComparator: (element1, element2) =>
                      element2.date.compareTo(element1.date),
                  useStickyGroupSeparators: true,
                  stickyHeaderBackgroundColor: const Color(0xFFECEFF1),
                  separator: const SizedBox(height: 1),
                  groupSeparatorBuilder: _groupSeparator,
                  itemBuilder: (context, element) => _itemWidget(element),
                ),
        ),
      ),
    );
  }

  Widget noRecordView() {
    return const Center(
      child: Text('目標を設定し、記録を入力しよう！'),
    );
  }

  Widget _groupSeparator(String value) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 4, right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
          ),
          Text(
            '合計: ${fetchMonthlyTotal(value)} ${goal?.unit}',
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }

  Widget _itemWidget(Record record) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${record.date.month}月 ${record.date.day}日'),
          Text('${((record.amount) * 10).ceil() / 10} ${goal?.unit}')
        ],
      ),
    );
  }

  int fetchMonthlyTotal(String dateString) {
    final dateParts = dateString.split('年');
    final year = int.parse(dateParts[0]);
    final month = int.parse(dateParts[1].split('月')[0]);

    var total = 0.0;

    for (final record in ref.watch(recordListProvider)) {
      if (record.date.year == year && record.date.month == month) {
        total += record.amount;
      }
    }

    return total.toInt();
  }
}
