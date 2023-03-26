import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:lets1000_android/database/goal_db.dart';
import 'package:lets1000_android/database/record_db.dart';
import 'package:lets1000_android/view_model/record_list_view_model.dart';

class RecordListView extends StatefulWidget {
  const RecordListView({super.key});

  @override
  State<RecordListView> createState() => _RecordListViewState();
}

class _RecordListViewState extends State<RecordListView> {
  final viewModel = RecordListViewModel();
  Goal? goal;

  @override
  Future<void> initState() async {
    super.initState();
    final g = await viewModel.fetchGoal();
    setState(() => goal = g);

    viewModel.recordListStream.listen((recordList) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('頑張った記録')),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        color: Colors.blueGrey[50],
        child:
            !(viewModel.recordList != null && viewModel.recordList!.isNotEmpty)
                ? noRecordView()
                : GroupedListView(
                    elements: viewModel.recordList!,
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
            '合計: ${viewModel.fetchMonthlyTotal(value)} ${goal?.unit}',
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
}
