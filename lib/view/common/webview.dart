import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key, required this.url});
  final String url;

  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  late WebViewController controller;

  bool isLoading = false;
  String loadedTitle = '';

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (url) async {
            setState(() {
              isLoading = false;
            });
            final t = await controller.getTitle();
            setState(() {
              if (t != null) {
                loadedTitle = t;
              }
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedTitle),
      ),
      body: Column(
        children: [
          if (isLoading) const LinearProgressIndicator(),
          Expanded(child: WebViewWidget(controller: controller)),
        ],
      ),
    );
  }
}
