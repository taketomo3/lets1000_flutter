import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lets1000_android/database/database_helper.dart';
import 'package:lets1000_android/view/home_view.dart';
import 'package:lets1000_android/database/goal_db.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '1000',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const HomeView(),
    );
  }
}
