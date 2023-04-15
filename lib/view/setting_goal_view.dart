import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lets1000_android/view/common/toast.dart';
import 'package:lets1000_android/view_model/setting_goal_view_model.dart';

class SettingGoalView extends HookConsumerWidget {
  const SettingGoalView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unit = useState<String>('');
    final goal = useState<String>('');

    final viewModel = ref.watch(settingGoalViewModelProvider.notifier);

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
                  unit.value = value;
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
                  goal.value = value;
                },
              ),
            ),
            const Text('します！！'),
          ],
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: (unit.value.isEmpty || goal.value.isEmpty)
              ? null
              : () => onRegistered(
                    context,
                    viewModel,
                    goal.value,
                    unit.value,
                  ),
          child: const Text('登録'),
        ),
      ],
    );
  }

  Future<void> onRegistered(
    BuildContext context,
    SettingGoalViewModelProvider viewModel,
    String goal,
    String unit,
  ) async {
    final _ = viewModel.addGoal(goal, unit);

    Navigator.of(context).pop();
    showToast(
      FToast().init(context),
      viewModel.toastMessages(),
    );
  }
}
