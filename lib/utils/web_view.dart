import 'dart:io';
import 'package:flutter/material.dart';
import 'package:luxepass/constants/constant.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

import '../providers/web_loading_provider.dart';

class WebViewScreen extends StatefulWidget {
  final String link;

  const WebViewScreen({required this.link});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final LoadingWebPageBloc loadingWebPageBloc = LoadingWebPageBloc();
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: themColors309D9D,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios),
          )),
      body: Container(
        child: Stack(
          children: <Widget>[
            WebView(
              initialUrl: widget.link,
              javascriptMode: JavascriptMode.unrestricted,
              onPageStarted: (value) {
                loadingWebPageBloc.changeLoadingWebPage(true);
              },
              onPageFinished: (value) {
                loadingWebPageBloc.changeLoadingWebPage(false);
              },
            ),
            StreamBuilder<bool>(
              stream: loadingWebPageBloc.loadingWebPageStream,
              initialData: true,
              builder: (context, snap) {
                if (snap.hasData && snap.data == true) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: themColors309D9D,
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
