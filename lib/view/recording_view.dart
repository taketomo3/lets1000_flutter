import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lets1000_android/database/record_db.dart';
import 'package:lets1000_android/repository/goal_repository.dart';
import 'package:lets1000_android/view/common/toast.dart';

class RecordingView extends ConsumerStatefulWidget {
  const RecordingView({super.key});

  @override
  RecordingViewState createState() => RecordingViewState();
}

class RecordingViewState extends ConsumerState<RecordingView> {
  double? amount;
  int dateIndex = 0;

  @override
  Widget build(BuildContext context) {
    final goal = ref.watch(goalProvider);
    return Column(
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
                  setState(() => amount = double.tryParse(value));
                },
              ),
            ),
            Text(goal?.unit ?? '')
          ],
        ),
        const SizedBox(height: 10),
        Text('${goal?.goal}しました！！'),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: amount == null ? null : onRegister,
          child: const Text('記録する'),
        ),
      ],
    );
  }

  Row dateChooseWidget() {
    void updateDate(int? i) => setState(() => dateIndex = i!);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Radio(
              value: 0,
              groupValue: dateIndex,
              onChanged: updateDate,
            ),
            const Text('今日')
          ],
        ),
        Row(
          children: [
            Radio(
              value: 1,
              groupValue: dateIndex,
              onChanged: updateDate,
            ),
            const Text('昨日')
          ],
        ),
      ],
    );
  }

  void onRegister() {
    createRecord();

    Navigator.of(context).pop();
    showToast(
      FToast().init(context),
      [
        'ナイス！！',
        'お疲れ様です！！',
        'いい調子ですね！',
        '！！！！',
        '記録しました！',
      ],
    );
  }

  void createRecord() {
    final dateList = [
      DateTime.now(),
      DateTime.now().subtract(const Duration(days: 1))
    ];
    Record.insert(amount!, dateList[dateIndex]);
  }
}
