import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class CimriWebView extends StatefulWidget {
  final String link2;

  const CimriWebView({Key key, this.link2}) : super(key: key);
  @override
  _CimriWebViewState createState() => _CimriWebViewState(link2);
}

class _CimriWebViewState extends State<CimriWebView> {
  final String link2;
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  _CimriWebViewState(this.link2);
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context);
        },
        shape: RoundedRectangleBorder(),
        label: Text('Back to Results'),
        backgroundColor: Theme.of(context).accentColor,
        icon: Icon(Icons.arrow_back),
      ),
      body: WebView(
        initialUrl: link2,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}