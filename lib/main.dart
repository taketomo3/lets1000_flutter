import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lets1000_android/view/tab_view.dart';

void main() {
  // package_info_plusの初期化
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: '1000',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const TabView(),
    );
  }
}
