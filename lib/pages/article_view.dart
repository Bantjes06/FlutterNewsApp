import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  String blogUrl;
  ArticleView({super.key, required this.blogUrl});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Flutter',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ),
              Text(
                'News',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
              )
            ],
          ),
          centerTitle: true,
          leading: const BackButton(color: Colors.black,),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Container(
          child: WebView(
            initialUrl: widget.blogUrl,
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ));
  }
}
