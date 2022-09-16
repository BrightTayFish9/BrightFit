import 'package:bright_fit/controllers/singleton.dart';
import 'package:bright_fit/models/post_skel.dart';
import 'package:bright_fit/widgets/post_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

///Displays the WordPress post selected by the user
class PostView extends StatefulWidget {
  final PostSkel _post;

  PostView(this._post);

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  InAppWebViewController webView;
  String url;
  double progress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            //TODO: Fix this for short titles
            width: MediaQuery.of(context).size.width, // * (9 / 10),
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Text(
                widget._post.title.toUpperCase(),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: Uri.parse(widget._post.link)),
                initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                )),
                onWebViewCreated: (InAppWebViewController controller) {
                  webView = controller;
                },
                onLoadStart: (controller, url) {
                  setState(() {
                    this.url = url.toString();
                  });
                },
                onLoadStop: (controller, url) async {
                  setState(() {
                    this.url = url.toString();
                  });
                },
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
              ),
            ),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Theme.of(context).highlightColor,
              valueColor:
                  AlwaysStoppedAnimation<Color>(Singleton().model.color),
            ),
            PostButtons(widget._post)
          ],
        ));
  }
}
