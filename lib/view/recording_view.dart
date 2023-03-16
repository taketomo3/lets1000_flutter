import 'package:flutter/material.dart';
import 'package:lets1000_android/database/goal_db.dart';
import 'package:lets1000_android/database/record_db.dart';

class RecordingView extends StatefulWidget {
  const RecordingView({Key? key}) : super(key: key);

  @override
  State<RecordingView> createState() => _RecordingViewState();
}

class _RecordingViewState extends State<RecordingView> {
  double? amount;
  int dateIndex = 0;

  Goal goal = Goal(id: 1, goal: 'ランニング', unit: 'km', createdAt: DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 100),
        dateChooseWidget(),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: 100,
              child: TextField(
                autofocus: true,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    amount = double.tryParse(value);
                  });
                },
              ),
            ),
            Text(goal.unit)
          ],
        ),
        const SizedBox(height: 10),
        Text('${goal.goal}しました！！'),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: amount == null ? null : () => onRegistered(),
          child: const Text('記録する'),
        ),
      ],
    );
  }

  void onRegistered() {
    if (amount == null) {
      return;
    }

    final List<DateTime> dateList = [
      DateTime.now(),
      DateTime.now().subtract(const Duration(days: -1))
    ];

    Record.insert(amount!, dateList[dateIndex])
        .then((id) => {Navigator.of(context).pop()});
  }

  Row dateChooseWidget() {
    void updateDate(int? i) => setState(() {
          if (i != null) {
            dateIndex = i;
          }
        });

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(children: [
          Radio(
            value: 0,
            groupValue: dateIndex,
            onChanged: (i) {
              updateDate(i);
            },
          ),
          const Text('今日')
        ]),
        Row(children: [
          Radio(
            value: 1,
            groupValue: dateIndex,
            onChanged: (i) {
              updateDate(i);
            },
          ),
          const Text('昨日')
        ]),
      ],
    );
  }
}
