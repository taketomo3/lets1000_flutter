import 'package:flutter/material.dart';
import 'package:lets1000_android/database/goal_db.dart';
import 'package:lets1000_android/view_model/home_view_model.dart';

class SettingGoalView extends StatefulWidget {
  const SettingGoalView({Key? key}) : super(key: key);

  @override
  State<SettingGoalView> createState() => _SettingGoalViewState();
}

class _SettingGoalViewState extends State<SettingGoalView> {
  String unit = '';
  String goal = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 100),
        const Text('2023年、私は'),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text('1000', style: TextStyle(fontSize: 54)),
            SizedBox(
              width: 100,
              child: TextField(
                autofocus: true,
                decoration: const InputDecoration(hintText: '時間'),
                onChanged: (value) {
                  unit = value;
                },
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: 200,
              child: TextField(
                decoration: const InputDecoration(hintText: '読書'),
                onChanged: (value) {
                  goal = value;
                },
              ),
            ),
            const Text('します！！'),
          ],
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: (unit.isNotEmpty && goal.isNotEmpty)
              ? () => {
                    Goal.insert(goal, unit)
                        .then((id) => {Navigator.of(context).pop()})
                  }
              : null,
          child: const Text('登録'),
        ),
      ],
    );
  }
}
