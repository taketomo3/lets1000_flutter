import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lets1000_android/database/goal_db.dart';
import 'package:lets1000_android/view_model/home_view_model.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Goal? goal = ref.watch(goalProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: goal == null ? settingGoalView() : progressView(),
      ),
    );
  }

  Column progressView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [Text("has goal and record")],
    );
  }

  Column settingGoalView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          '2023年に『1000』を達成しよう',
          style: TextStyle(fontSize: 32),
        ),
        TextButton(
            onPressed: () {
              print("onpress");
            },
            child: const Text('目標を設定'))
      ],
    );
  }
}

// class MyHomeView extends ConsumerStatefulWidget {
//   const MyHomeView({Key? key}) : super(key: key);
//   @override
//   MyHomeViewState createState() => MyHomeViewState();
// }

// class MyHomeViewState extends ConsumerState<MyHomeView> {
//   @override
//   void initState() {
//     super.initState();
//     ref.read(hasGoalProvider);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final hasGoal = ref.watch(hasGoalProvider);
//     return ProviderScope(
//         overrides: [hasGoalProvider.overrideWith((ref) => hasGoal != null)],
//         child: Scaffold(
//           appBar: AppBar(),
//           body: Center(
//             child: hasGoal ? progressView() : settingGoalView(),
//           ),
//         ));
//   }

//   Column progressView() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: const [Text("has goal and record")],
//     );
//   }

//   Column settingGoalView() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         const Text(
//           '2023年に『1000』を達成しよう',
//           style: TextStyle(fontSize: 32),
//         ),
//         TextButton(
//             onPressed: () {
//               print("onpress");
//             },
//             child: const Text('目標を設定'))
//       ],
//     );
//   }
// }
