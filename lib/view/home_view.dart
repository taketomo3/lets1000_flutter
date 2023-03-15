import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lets1000_android/database/goal_db.dart';
import 'package:lets1000_android/view/setting_goal_view.dart';
import 'package:lets1000_android/view_model/home_view_model.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Goal? goal = ref.watch(goalProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: goal == null ? settingGoalView(context) : progressView(goal),
      ),
    );
  }

  Column progressView(Goal goal) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('今年の目標'),
        Text('1000${goal.unit} ${goal.goal}します！！！'),
        const SizedBox(height: 120),
        circleView(278),
        const SizedBox(height: 150),
        TextButton(
            onPressed: () {
              print("onpress");
            },
            child: const Text('記録する'))
      ],
    );
  }

  Stack circleView(int value) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        CustomPaint(
          painter: CirclePainter(value),
        ),
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

  Column settingGoalView(BuildContext context) {
    return Column(
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
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return Container(
                      margin: const EdgeInsets.only(top: 64),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: const SettingGoalView(),
                    );
                  });
              const SettingGoalView();
            },
            child: const Text('目標を設定'))
      ],
    );
  }
}

class CirclePainter extends CustomPainter {
  final int value;

  CirclePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.color = Colors.indigo;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 30;

    final endAngle = value / 1000 * pi * 2;

    canvas.drawArc(const Offset(-100, -100) & const Size(200, 200), -pi / 2,
        endAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
