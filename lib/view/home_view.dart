import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lets1000_android/view/common/modal_sheet.dart';
import 'package:lets1000_android/view/recording_view.dart';
import 'package:lets1000_android/view/setting_goal_view.dart';
import 'package:lets1000_android/view_model/home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final viewModel = HomeViewModel();
  bool? hasGoal;

  @override
  void initState() {
    super.initState();
    viewModel.hasGoalStream.listen((b) {
      setState(() => hasGoal = b);
    });

    viewModel.totalAmountStream.listen((event) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return hasGoal == null
        ? const LinearProgressIndicator()
        : hasGoal == true
            ? progressView(context)
            : settingGoalView(context);
  }

  Widget progressView(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('今年の目標'),
          Text('1000${viewModel.goal?.unit} ${viewModel.goal?.goal}します！！！'),
          const SizedBox(height: 120),
          circleView(viewModel.totalAmount ?? 0),
          const SizedBox(height: 150),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showAlmostFullModal(context, const RecordingView(), updateState);
          }),
    );
  }

  void updateState() {
    setState(() {
      viewModel.fetchGoal();
      viewModel.fetchTotalAmount();
    });
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
                context, const SettingGoalView(), updateState),
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
