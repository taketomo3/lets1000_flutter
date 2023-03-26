import 'dart:async';

import 'package:lets1000_android/constant.dart';
import 'package:lets1000_android/data_class/document_element.dart';
import 'package:lets1000_android/data_class/group_element.dart';
import 'package:lets1000_android/database/goal_db.dart';
import 'package:lets1000_android/database/record_db.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DocumentViewModel {
  DocumentViewModel() {
    _fetchRecordList();
    _fetchGoal();
    _fetchAppVer();
  }

  List<Record>? _recordList;
  Goal? _goal;
  PackageInfo? _packageInfo;

  final _isPreparedController = StreamController<bool>.broadcast();
  Stream<bool> get isPreparedStream => _isPreparedController.stream;

  void dispose() {
    _isPreparedController.close();
  }

  bool _allPrepared() {
    return _recordList != null && _packageInfo != null;
  }

  /* 表示に必要な非同期データを取得 */
  void _fetchRecordList() {
    Record.fetchAll().then((value) {
      _recordList = value;
      _isPreparedController.add(_allPrepared());
    });
  }

  void _fetchGoal() {
    Goal.fetchLast().then((value) {
      _goal = value;
      _isPreparedController.add(_allPrepared());
    });
  }

  void _fetchAppVer() {
    PackageInfo.fromPlatform().then((value) {
      _packageInfo = value;
      _isPreparedController.add(_allPrepared());
    });
  }
  /* ここまで */

  /* Viewに渡すデータ */
  List<DocumentElement> fetchElements() {
    return [
      DocumentElement(
        groupId: 1,
        id: 1,
        title: '合計数',
        value: '${_fetchTotalAmount()} ${_goal?.unit ?? ''}',
      ),
      DocumentElement(
        groupId: 1,
        id: 2,
        title: '登録回数',
        value: '${_fetchTotalCount()} 回',
      ),
      DocumentElement(
        groupId: 1,
        id: 3,
        title: '1回あたりの平均',
        value: '${_fetchAverageAmount()} ${_goal?.unit ?? ''}',
      ),
      DocumentElement(
        groupId: 1,
        id: 4,
        title: 'このペースでいくと2023年中に',
        value: '${_fetchExpectedTotalAmount()} ${_goal?.unit ?? ''}',
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
        value: '${_packageInfo?.version}(${_packageInfo?.buildNumber})',
      ),
      DocumentElement(
        groupId: 3,
        id: 2,
        title: '更新日',
        value: updateDate,
      ),
    ];
  }

  GroupElement fetchGroup(int id) {
    final groups = [
      GroupElement(id: 1, name: '統計データ'),
      GroupElement(id: 2, name: 'アプリについて'),
      GroupElement(id: 3, name: 'アプリ情報'),
    ];

    return groups.firstWhere((element) => element.id == id);
  }
  /* ここまで */

  /* DocumentElementで使用 */
  double _fetchTotalAmount() {
    var total = 0.0;
    _recordList?.forEach((record) {
      total += record.amount;
    });
    return total;
  }

  int _fetchTotalCount() {
    return _recordList?.length ?? 0;
  }

  double _fetchAverageAmount() {
    if (_recordList == null || _recordList!.isEmpty) {
      return 0;
    }

    final average = _fetchTotalAmount() / _fetchTotalCount();
    return (average * 10).toInt() / 10;
  }

  int _fetchExpectedTotalAmount() {
    if (_recordList == null || _recordList!.isEmpty) {
      return 0;
    }

    final startDate = DateTime(
      2023,
    );
    final today = DateTime.now();

    final daysSinceStart = today.difference(startDate).inDays;
    const totalDaysInYear = 365;

    final expectedTotalAmount =
        (totalDaysInYear / daysSinceStart) * _fetchTotalAmount();
    return expectedTotalAmount.toInt();
  }
}
