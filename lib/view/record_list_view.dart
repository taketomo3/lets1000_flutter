import 'package:flutter/material.dart';

class RecordListView extends StatelessWidget {
  const RecordListView({super.key});

  @override
  Widget build(BuildContext context) {
    const data = [
      Text("item0"),
      Text("item1"),
      Text("item2"),
      Text("item3"),
      Text("item4"),
    ];
    return ListView(children: data);
  }
}
