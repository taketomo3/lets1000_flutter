import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lets1000_android/model/record.dart';
import 'package:lets1000_android/view_model/my_state_view_model.dart';
import 'package:lets1000_android/view_model/record_list_view_model.dart';

class RecordListView extends HookConsumerWidget {
  const RecordListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(myStateProvider);
    final viewModel = ref.watch(recordListViewModelProvider.notifier);

    final goalUnit = state.goal?.unit ?? '';

    return Scaffold(
      appBar: AppBar(title: const Text('頑張った記録')),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        color: Colors.blueGrey[50],
        child: state.goal == null || state.recordList.isEmpty
            ? noRecordView()
            : GroupedListView(
                elements: state.recordList,
                groupBy: (record) =>
                    '${record.date.year}年 ${record.date.month}月',
                order: GroupedListOrder.DESC,
                itemComparator: (r1, r2) => r2.date.compareTo(r1.date),
                useStickyGroupSeparators: true,
                stickyHeaderBackgroundColor: const Color(0xFFECEFF1),
                separator: const SizedBox(height: 1),
                groupSeparatorBuilder: (ym) =>
                    _groupSeparator(viewModel, ym, goalUnit),
                itemBuilder: (_, record) => _itemWidget(record, goalUnit),
              ),
      ),
    );
  }

  Widget noRecordView() {
    return const Center(
      child: Text('目標を設定し、記録を入力しよう！'),
    );
  }

  Widget _groupSeparator(
    RecordListViewModelProvider viewModel,
    String ym,
    String goalUnit,
  ) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 4, right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            ym,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
          ),
          Text(
            '合計: ${viewModel.fetchMonthlyTotal(ym)} $goalUnit',
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }

  Widget _itemWidget(Record record, String goalUnit) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${record.date.month}月 ${record.date.day}日'),
          Text('${((record.amount) * 10).ceil() / 10} $goalUnit')
        ],
      ),
    );
  }
}
