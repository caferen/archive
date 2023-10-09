import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:sms/sms.dart';

void main() => runApp(Srs());

class Srs extends StatefulWidget {
  @override
  _SrsState createState() => _SrsState();
}

class _SrsState extends State<Srs> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  WebViewController _webViewController;
  SmsReceiver receiver = new SmsReceiver();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Builder(
            builder: (context) => WebView(
              initialUrl: 'redacted',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (webViewController) {
                _controller.complete(webViewController);
                _webViewController = webViewController;
              },
              onPageFinished: (url) {
                if (url.toLowerCase().contains('login')) {
                  _webViewController.evaluateJavascript(
                    '''
                    document.getElementById('LoginForm_username').value='redacted';
                    document.getElementById('LoginForm_password').value='redacted';
                    document.getElementsByName('yt0')[0].click();
                  ''',
                  );
                } else if (url.toLowerCase().contains('verify')) {
                  receiver.onSmsReceived.listen(
                    (SmsMessage msg) => _webViewController.evaluateJavascript(
                      '''
                  document.getElementById('SmsVerifyForm_verifyCode').value=${msg.body.split(" ").elementAt(2)};
                  document.getElementsByName('yt0')[0].click();
                  ''',
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
