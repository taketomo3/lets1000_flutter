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
      body: GroupedListView(
        elements: recordList,
        groupBy: (record) => "${record.date.year}年 ${record.date.month}月",
        groupSeparatorBuilder: (String value) => Padding(
            padding:
                const EdgeInsets.only(top: 20, bottom: 4, right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value,
                    style: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.w300)),
                const Text(
                  "200km",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
                ),
              ],
            )),
        itemBuilder: (context, element) => _itemWidget(element),
      ),
    );
  }

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

  Widget _itemWidget(Record record) {
    return Column(children: [
      Container(
        color: Colors.grey[100],
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(_toMonthDate(record.date)),
              Text("${(record.amount) * 10.ceil() / 10} ${goal.unit}")
            ],
          ),
        ),
      ),
      Divider(
        color: Colors.grey[300], // Dividerの色を設定
        thickness: 1, // Dividerの太さを設定
        height: 1,
        indent: 10,
        endIndent: 10,
      )
    ]);
  }

  String _toMonthDate(DateTime date) {
    return "${date.month}月 ${date.day}日";
  }
}
