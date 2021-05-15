import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stack_finance_assignment/util/color/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// web view used to load url
class WebViewScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  /// web view constructor with title and url
  WebViewScreen(this.data);

  @override
  State createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  bool _isLoadingPage;

  final Set<Factory> gestureRecognizers = [
    Factory(() => VerticalDragGestureRecognizer()),
  ].toSet();

  @override
  void initState() {
    super.initState();
    _isLoadingPage = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.clear,
              color: white,
            ),
          ),
          centerTitle: true,
          title: Text(
            '${widget.data['title']}',
            style: TextStyle(color: white),
          ),
        ),
        body: Stack(
          children: [
            WebView(
                initialUrl: widget.data['url'],
                onPageFinished: (String url) {
                  if (_isLoadingPage) {
                    _isLoadingPage = false;
                    setState(() {});
                  }
                },
                navigationDelegate: (request) {
                  if (request.url != widget.data['url'])
                    return NavigationDecision.prevent;
                  else
                    return NavigationDecision.navigate;
                }),
            _isLoadingPage
                ? Container(
                    color: primaryColor,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  )
                : Container()
          ],
        ));
  }
}
