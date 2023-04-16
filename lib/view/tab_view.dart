import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lets1000_android/view/document_view.dart';
import 'package:lets1000_android/view/home_view.dart';
import 'package:lets1000_android/view/record_list_view.dart';

class TabView extends HookConsumerWidget {
  const TabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabIndex = useState<int>(0);

    final screens = [
      const HomeView(),
      const RecordListView(),
      const DocumentView(),
    ];

    return Scaffold(
      body: screens[tabIndex.value],
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
        currentIndex: tabIndex.value,
        onTap: (value) {
          tabIndex.value = value;
        },
      ),
    );
  }
}
