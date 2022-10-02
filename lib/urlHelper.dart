import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';






class NewScreen extends StatelessWidget {
  var urlweb = 'https://news.ycombinator.com/';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter WebView'),
      ),
      body: WebView(
        initialUrl: urlweb,
      ),
    );
  }
}
