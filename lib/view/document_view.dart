import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:lets1000_android/constant.dart';
import 'package:lets1000_android/database/goal_db.dart';
import 'package:lets1000_android/view/common/webview.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DocumentView extends StatefulWidget {
  const DocumentView({super.key});

  @override
  State<DocumentView> createState() => _DocumentViewState();
}

class _DocumentViewState extends State<DocumentView> {
  Goal? goal;
  PackageInfo? packageInfo;

  @override
  void initState() {
    super.initState();
    fetchGoal();
    getVer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("その他")),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        color: Colors.blueGrey[50],
        child: GroupedListView(
          elements: _fetchElements(),
          groupBy: (e) => _fetchGroup(e.groupId).id.toString(),
          groupComparator: (v1, v2) => v1.compareTo(v2),
          itemComparator: (e1, e2) => e1.id.compareTo(e2.id),
          separator: const SizedBox(height: 1),
          groupSeparatorBuilder: (String value) => _groupSeparator(value),
          itemBuilder: (context, element) => _itemWidget(element),
        ),
      ),
    );
  }

  Widget _groupSeparator(String value) {
    final id = int.parse(value);
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 4, right: 20, left: 20),
      child: Text(_fetchGroup(id).name),
    );
  }

  Widget _itemWidget(DocumentElement element) {
    void onTap() {
      if (element.url == null) {
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WebViewPage(
                  url: element.url!,
                  title: element.title,
                )),
      );
    }

    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
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

  GroupElement _fetchGroup(int id) {
    final groups = [
      GroupElement(id: 1, name: "統計データ"),
      GroupElement(id: 2, name: "アプリについて"),
      GroupElement(id: 3, name: "アプリ情報"),
    ];

    return groups.firstWhere((element) => element.id == id);
  }

  Future getVer() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      packageInfo = info;
    });
  }

  Future fetchGoal() async {
    Goal.fetchLast().then((g) => {
          setState(() {
            goal = g;
          })
        });
  }

  List<DocumentElement> _fetchElements() {
    return [
      DocumentElement(
        groupId: 1,
        id: 1,
        title: "合計数",
        value: "278.0 ${goal?.unit}",
      ),
      DocumentElement(
        groupId: 1,
        id: 2,
        title: "登録回数",
        value: "19 回",
      ),
      DocumentElement(
        groupId: 1,
        id: 3,
        title: "1回あたりの平均",
        value: "14.7 ${goal?.unit}",
      ),
      DocumentElement(
        groupId: 1,
        id: 4,
        title: "このペースでいくと2023年中に",
        value: "1374 ${goal?.unit}",
      ),
      DocumentElement(
        groupId: 2,
        id: 1,
        title: "開発ロードマップ",
        url: ConstantData.roadmapPath,
      ),
      DocumentElement(
        groupId: 2,
        id: 2,
        title: "お問い合わせ",
        url: ConstantData.contactFormPath,
      ),
      DocumentElement(
        groupId: 2,
        id: 3,
        title: "Playストアを確認",
        url: ConstantData.playStorePath,
      ),
      DocumentElement(
        groupId: 3,
        id: 1,
        title: "アプリバージョン",
        value: packageInfo == null
            ? "-"
            : "${packageInfo?.version}(${packageInfo?.buildNumber})",
      ),
      DocumentElement(
        groupId: 3,
        id: 2,
        title: "更新日",
        value: ConstantData.updateDate,
      ),
    ];
  }
}

class DocumentElement {
  int groupId;
  int id;
  String title;
  String? value;
  String? url;

  DocumentElement({
    required this.groupId,
    required this.id,
    required this.title,
    this.value,
    this.url,
  });
}

class GroupElement {
  int id;
  String name;

  GroupElement({
    required this.id,
    required this.name,
  });
}
