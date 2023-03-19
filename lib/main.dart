import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lets1000_android/View/record_list_view.dart';
import 'package:lets1000_android/view/document_view.dart';
import 'package:lets1000_android/view/home_view.dart';

void main() {
  // package_info_plusの初期化
  WidgetsFlutterBinding.ensureInitialized();

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
        home: const TabView());
  }
}

class TabView extends StatefulWidget {
  const TabView({super.key});

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  int _selectedIndex = 0;

  final _screens = [
    const HomeView(),
    RecordListView(),
    const DocumentView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'トップ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'ログ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'その他',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
