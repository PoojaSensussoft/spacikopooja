import 'dart:io';

import 'package:flutter/material.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsCond extends StatefulWidget {
  @override
  _TermsCondState createState() => _TermsCondState();
}

class _TermsCondState extends State<TermsCond> {
  bool isLoading=true;
  final _key = UniqueKey();

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            backgroundColor: spacikoColor.ColorPrimary,
          ),
        ),

        body: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_sharp, color: spacikoColor.Colorblack), iconSize: 25,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  WebView(
                    key: _key,
                    initialUrl: 'https://flutter.dev',
                    javascriptMode: JavascriptMode.unrestricted,
                    onPageFinished: (finish) {
                      setState(() {
                        isLoading = false;
                      });
                    },
                  ),
                  isLoading ? Center( child: CircularProgressIndicator(),)
                      : Stack(),
                ],
              ),
            ),
          ],

        ),
      ),
    );
  }
}
