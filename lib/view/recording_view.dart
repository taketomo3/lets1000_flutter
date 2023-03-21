import 'package:flutter/material.dart';
import 'package:lets1000_android/database/goal_db.dart';
import 'package:lets1000_android/view_model/recording_view_model.dart';

class RecordingView extends StatefulWidget {
  const RecordingView({Key? key}) : super(key: key);

  @override
  State<RecordingView> createState() => _RecordingViewState();
}

class _RecordingViewState extends State<RecordingView> {
  final viewModel = RecordingViewModel();
  Goal? goal;

  double? amount;
  int dateIndex = 0;

  @override
  void initState() {
    super.initState();
    viewModel.fetchGoal().then((value) {
      setState(() => goal = value);
    });
  }

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
                  setState(() => amount = double.tryParse(value));
                },
              ),
            ),
            Text(goal?.unit ?? "")
          ],
        ),
        const SizedBox(height: 10),
        Text('${goal?.goal}しました！！'),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: amount == null
              ? null
              : () {
                  viewModel.onRegistered(
                      amount!, dateIndex, Navigator.of(context).pop());
                },
          child: const Text('記録する'),
        ),
      ],
    );
  }

  Row dateChooseWidget() {
    void updateDate(int? i) => setState(() {
          if (i != null) dateIndex = i;
        });

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(children: [
          Radio(
            value: 0,
            groupValue: dateIndex,
            onChanged: (i) => updateDate(i),
          ),
          const Text('今日')
        ]),
        Row(children: [
          Radio(
            value: 1,
            groupValue: dateIndex,
            onChanged: (i) => updateDate(i),
          ),
          const Text('昨日')
        ]),
      ],
    );
  }
}
