import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _webViewController;
  int progress = 0;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..loadRequest(Uri.parse(
          "https://jusmarktech.in/mpculturedept/artistregistration.php"))
      ..setNavigationDelegate(NavigationDelegate(onPageStarted: (url) {
        setState(() {
          progress = 0;
        });
      }, onProgress: (progr) {
        setState(() {
          progress = progr;
        });
      }, onPageFinished: (url) {
        setState(() {
          progress = 100;
        });
      }))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel("a", onMessageReceived: (message) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message.toString())));
      });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool canNavigate = await _webViewController.canGoBack();
        if (canNavigate) {
          _webViewController.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Stack(
              children: [
                WebViewWidget(
                  controller: _webViewController,
                ),
                if (progress < 100)
                  LinearProgressIndicator(
                    value: progress / 100,
                  )
              ],
            ),
          )),
    );
  }
}
