import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lets1000_android/database/goal_db.dart';
import 'package:lets1000_android/view/common/toast.dart';

class SettingGoalView extends StatefulWidget {
  const SettingGoalView({super.key});

  @override
  State<SettingGoalView> createState() => _SettingGoalViewState();
}

class _SettingGoalViewState extends State<SettingGoalView> {
  String unit = '';
  String goal = '';
  FToast fToast = FToast();

  @override
  void initState() {
    super.initState();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  setState(() {
                    unit = value;
                  });
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
                  setState(() {
                    goal = value;
                  });
                },
              ),
            ),
            const Text('します！！'),
          ],
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: (unit.isEmpty || goal.isEmpty) ? null : onRegistered,
          child: const Text('登録'),
        ),
      ],
    );
  }

  Future<void> onRegistered() async {
    await Goal.insert(goal, unit);
    if (!mounted) {
      return;
    }
    Navigator.of(context).pop();
    showToast(fToast, ['素敵な目標ですね！', 'これから頑張りましょう！']);
  }
}
