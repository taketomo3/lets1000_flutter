import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:lets1000_android/data_class/document_element.dart';
import 'package:lets1000_android/view/common/webview.dart';
import 'package:lets1000_android/view_model/document_view_model.dart';

class DocumentView extends StatefulWidget {
  const DocumentView({super.key});

  @override
  State<DocumentView> createState() => _DocumentViewState();
}

class _DocumentViewState extends State<DocumentView> {
  final viewModel = DocumentViewModel();
  bool isPrepared = false;

  @override
  void initState() {
    super.initState();

    viewModel.isPreparedStream.listen((b) {
      setState(() => isPrepared = b);
    });
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("その他")),
      body: !isPrepared
          ? const LinearProgressIndicator()
          : Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              color: Colors.blueGrey[50],
              child: GroupedListView(
                elements: viewModel.fetchElements(),
                groupBy: (e) => viewModel.fetchGroup(e.groupId).id.toString(),
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
      child: Text(viewModel.fetchGroup(id).name),
    );
  }

  Widget _itemWidget(DocumentElement element) {
    void onTap() {
      if (element.url == null) {
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WebViewPage(url: element.url!)),
      );
    }

    return GestureDetector(
      onTap: () => onTap(),
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
}
