import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;

  const WebViewPage({super.key, required this.url, required this.title});

  @override
  createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      // ..setNavigationDelegate(NavigationDelegate(
      //   onProgress: (progress) => {},
      //   onPageStarted: (url) {

      //   },
      //   onNavigationRequest: (NavigationRequest request) {

      //   }
      // ))
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: WebViewWidget(controller: controller));
  }
}
