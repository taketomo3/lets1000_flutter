import 'package:flutter/material.dart';

class DocumentView extends StatelessWidget {
  const DocumentView({super.key});

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
