import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:lets1000_android/database/goal_db.dart';
import 'package:lets1000_android/database/record_db.dart';

class RecordListView extends StatelessWidget {
  RecordListView({super.key});

  final goal =
      Goal(id: 1, goal: "ランニング", unit: "km", createdAt: DateTime.now());

  @override
  Widget build(BuildContext context) {
    var recordList = _fetchData();

    return Scaffold(
      appBar: AppBar(title: const Text("頑張った記録")),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        color: Colors.blueGrey[50],
        child: GroupedListView(
          elements: recordList,
          groupBy: (record) => "${record.date.year}年 ${record.date.month}月",
          order: GroupedListOrder.DESC,
          itemComparator: (element1, element2) =>
              element2.date.compareTo(element1.date),
          useStickyGroupSeparators: true,
          stickyHeaderBackgroundColor: const Color(0xFFECEFF1),
          separator: const SizedBox(height: 1),
          groupSeparatorBuilder: (String value) => _groupSeparator(value),
          itemBuilder: (context, element) => _itemWidget(element),
        ),
      ),
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
          const Text(
            "合計: 200km",
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(_toMonthDate(record.date)),
          Text("${(record.amount) * 10.ceil() / 10} ${goal.unit}")
        ],
      ),
    );
  }

  /* メソッド */
  List<Record> _fetchData() {
    List<Record> data = [];
    DateTime date = DateTime.utc(DateTime.now().year, 1, 1);
    for (int i = 0; i < 20; i++) {
      date = date.add(const Duration(days: 3));
      data.add(
        Record(
          id: i,
          amount: i.toDouble(),
          date: date,
          createdAt: DateTime.now(),
        ),
      );
    }
    return data;
  }

  String _toMonthDate(DateTime date) {
    return "${date.month}月 ${date.day}日";
  }
}
