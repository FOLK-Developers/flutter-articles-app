import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ViewArticle extends StatelessWidget {
  final String filePath;
  ViewArticle({this.filePath});
  Future<String> readHTML() async {
    File htmlFile = File(filePath);
    String htmlString = await htmlFile.readAsString();
    return htmlString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: readHTML(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    print(snapshot.data);
                    return Html(data: snapshot.data);
                    break;
                  default:
                    return CircularProgressIndicator();
                }
              }),
        ),
      ),
    );
  }
}
