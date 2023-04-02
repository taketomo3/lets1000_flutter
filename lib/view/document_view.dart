import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:lets1000_android/constant.dart';
import 'package:lets1000_android/data_class/document_element.dart';
import 'package:lets1000_android/data_class/group_element.dart';
import 'package:lets1000_android/repository/goal_repository.dart';
import 'package:lets1000_android/repository/package_info_repository.dart';
import 'package:lets1000_android/repository/record_repository.dart';
import 'package:lets1000_android/view/common/webview.dart';

class DocumentView extends ConsumerStatefulWidget {
  const DocumentView({super.key});

  @override
  DocumentViewState createState() => DocumentViewState();
}

class DocumentViewState extends ConsumerState<DocumentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('その他')),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        color: Colors.blueGrey[50],
        child: GroupedListView(
          elements: fetchElements(),
          groupBy: (e) => fetchGroup(e.groupId).id.toString(),
          groupComparator: (v1, v2) => v1.compareTo(v2),
          itemComparator: (e1, e2) => e1.id.compareTo(e2.id),
          separator: const SizedBox(height: 1),
          groupSeparatorBuilder: _groupSeparator,
          itemBuilder: (context, element) => _itemWidget(element),
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

  Widget _itemWidget(DocumentElement element) {
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

  List<DocumentElement> fetchElements() {
    final packageInfo = ref.watch(packageInfoProvider).value;
    final goalUnit = ref.watch(goalProvider)?.unit ?? '';

    return [
      DocumentElement(
        groupId: 1,
        id: 1,
        title: '合計数',
        value: '${ref.watch(totalAmountProvider)} $goalUnit',
      ),
      DocumentElement(
        groupId: 1,
        id: 2,
        title: '登録回数',
        value: '${ref.watch(totalRecordCountProvider)} 回',
      ),
      DocumentElement(
        groupId: 1,
        id: 3,
        title: '1回あたりの平均',
        value: '${ref.watch(averageAmountProvider)} $goalUnit',
      ),
      DocumentElement(
        groupId: 1,
        id: 4,
        title: 'このペースでいくと2023年中に',
        value: '${ref.watch(expectedTotalAmountProvider)} $goalUnit',
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
      // DocumentElement(
      //   groupId: 2,
      //   id: 3,
      //   title: 'Playストアを確認',
      //   url: ConstantData.playStorePath,
      // ),
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
