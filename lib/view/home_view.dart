import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lets1000_android/state/state.dart';
import 'package:lets1000_android/view/common/modal_sheet.dart';
import 'package:lets1000_android/view/recording_view.dart';
import 'package:lets1000_android/view/setting_goal_view.dart';
import 'package:lets1000_android/view_model/home_view_model.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);
    final viewModel = ref.watch(homeViewModelProvider.notifier);

    return state.goal == null
        ? settingGoalView(context, viewModel)
        : progressView(context, state, viewModel);
  }

  Widget progressView(
    BuildContext context,
    MyState state,
    HomeViewModelProvider viewModel,
  ) {
    final goalObject = state.goal!;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('今年の目標'),
            Text('1000${goalObject.unit} ${goalObject.goal}します！！！'),
            const SizedBox(height: 120),
            circleView(state.totalRecordAmount),
            const SizedBox(height: 150),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showAlmostFullModal(context, const RecordingView(), () {
            viewModel.fetchTotalRecordAmount();
          });
        },
      ),
    );
  }

  Widget settingGoalView(
    BuildContext context,
    HomeViewModelProvider viewModel,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('2023年に'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                '『1000』',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Text('を達成しよう')
            ],
          ),
          const SizedBox(height: 100),
          TextButton(
            onPressed: () => showAlmostFullModal(
              context,
              const SettingGoalView(),
              () {
                viewModel.fetchGoal();
              },
            ),
            child: const Text('目標を設定'),
          ),
        ],
      ),
    );
  }

  Stack circleView(int value) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        CustomPaint(painter: CirclePainter(value)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('$value', style: const TextStyle(fontSize: 48)),
            const Text('/1000')
          ],
        )
      ],
    );
  }
}

class CirclePainter extends CustomPainter {
  CirclePainter(this.value);
  final int value;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.indigo
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30;

    final endAngle = value / 1000 * pi * 2;

    canvas.drawArc(
      const Offset(-100, -100) & const Size(200, 200),
      -pi / 2,
      endAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
