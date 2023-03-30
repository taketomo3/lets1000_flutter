import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lets1000_android/database/goal_db.dart';
import 'package:lets1000_android/repository/goal_repository.dart';
import 'package:lets1000_android/repository/record_repository.dart';
import 'package:lets1000_android/view/common/error_view.dart';
import 'package:lets1000_android/view/common/modal_sheet.dart';
import 'package:lets1000_android/view/recording_view.dart';
import 'package:lets1000_android/view/setting_goal_view.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    final goal = ref.watch(goalProvider);
    return goal.when(
      loading: () => const LinearProgressIndicator(),
      error: (error, _) => errorView(error),
      data: (goal) =>
          goal == null ? settingGoalView(context) : progressView(context, goal),
    );
  }

  Widget progressView(BuildContext context, Goal goal) {
    final totalAmount = ref.watch(totalAmountProvider);

    return totalAmount.when(
      loading: () => const LinearProgressIndicator(),
      error: (error, _) => errorView(error),
      data: (amount) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('今年の目標'),
              Text('1000${goal.unit} ${goal.goal}します！！！'),
              const SizedBox(height: 120),
              circleView(amount),
              const SizedBox(height: 150),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showAlmostFullModal(
              context,
              const RecordingView(),
              () {
                // do something?
              },
            );
          },
        ),
      ),
    );
  }

  Widget settingGoalView(BuildContext context) {
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
                // do something?
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
