import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:lets1000_android/constant.dart';
import 'package:lets1000_android/data_class/document_element.dart';
import 'package:lets1000_android/data_class/group_element.dart';
import 'package:lets1000_android/view/common/webview.dart';
import 'package:lets1000_android/view_model/document_view_model.dart';
import 'package:lets1000_android/view_model/my_state_view_model.dart';

class DocumentView extends ConsumerWidget {
  const DocumentView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('その他')),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        color: Colors.blueGrey[50],
        child: GroupedListView(
          elements: fetchElements(ref),
          groupBy: (e) => fetchGroup(e.groupId).id.toString(),
          groupComparator: (v1, v2) => v1.compareTo(v2),
          itemComparator: (e1, e2) => e1.id.compareTo(e2.id),
          separator: const SizedBox(height: 1),
          groupSeparatorBuilder: _groupSeparator,
          itemBuilder: _itemWidget,
        ),
      ),
    );
  }

  Widget _groupSeparator(String value) {
    final id = int.parse(value);
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 4, right: 20, left: 20),
      child: Text(fetchGroup(id).name),
    );
  }

  Widget _itemWidget(BuildContext context, DocumentElement element) {
    void onTap() {
      if (element.url == null) {
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute<WebViewPage>(
          builder: (context) => WebViewPage(url: element.url!),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(element.title),
            element.value != null
                ? Text(element.value!)
                : const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                  ),
          ],
        ),
      ),
    );
  }

  GroupElement fetchGroup(int id) {
    final groups = [
      GroupElement(id: 1, name: '統計データ'),
      GroupElement(id: 2, name: 'アプリについて'),
      GroupElement(id: 3, name: 'アプリ情報'),
    ];

    return groups.firstWhere((element) => element.id == id);
  }

  List<DocumentElement> fetchElements(WidgetRef ref) {
    final state = ref.watch(myStateProvider);
    final viewModel = ref.watch(documentViewModelProvider.notifier);

    final packageInfo = ref.watch(viewModel.packageInfoProvider).value;
    final goalUnit = state.goal?.unit ?? '';

    return [
      DocumentElement(
        groupId: 1,
        id: 1,
        title: '合計数',
        value: '${state.totalRecordAmount} $goalUnit',
      ),
      DocumentElement(
        groupId: 1,
        id: 2,
        title: '登録回数',
        value: '${state.recordList.length} 回',
      ),
      DocumentElement(
        groupId: 1,
        id: 3,
        title: '1回あたりの平均',
        value: '${viewModel.fetchAverageAmount()} $goalUnit',
      ),
      DocumentElement(
        groupId: 1,
        id: 4,
        title: 'このペースでいくと2023年中に',
        value: '${viewModel.fetchExpectedTotalAmount()} $goalUnit',
      ),
      DocumentElement(
        groupId: 2,
        id: 1,
        title: '開発ロードマップ',
        url: roadmapPath,
      ),
      DocumentElement(
        groupId: 2,
        id: 2,
        title: 'お問い合わせ',
        url: contactFormPath,
      ),
      DocumentElement(
        groupId: 2,
        id: 3,
        title: 'Playストアを確認',
        url: playStorePath,
      ),
      DocumentElement(
        groupId: 3,
        id: 1,
        title: 'アプリバージョン',
        value: '${packageInfo?.version}(${packageInfo?.buildNumber})',
      ),
      DocumentElement(
        groupId: 3,
        id: 2,
        title: '更新日',
        value: updateDate,
      ),
    ];
  }
}
