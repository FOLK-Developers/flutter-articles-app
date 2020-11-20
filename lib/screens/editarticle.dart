import 'dart:io';

import 'package:html_editor/html_editor.dart';
import 'package:flutter/material.dart';
import 'package:html_sample/filepath.dart';

class EditArticle extends StatefulWidget {
  @override
  _EditArticleState createState() => _EditArticleState();
}

class _EditArticleState extends State<EditArticle> {
  GlobalKey<HtmlEditorState> keyEditor = GlobalKey();
  Future<void> saveHTMLfile() async {
    var foldername, filename;
    await userArticlePath().then((dir) => foldername = dir.path);

    File htmlFile = File('$foldername/new1.html');
    if (!htmlFile.existsSync()) htmlFile.createSync(recursive: true);
    final htmlcontent = await keyEditor.currentState.getText();
    htmlFile.writeAsString(htmlcontent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: HtmlEditor(
                hint: "Your text here...",
                //value: "text content initial, if any",
                key: keyEditor,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlineButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                OutlineButton(
                  onPressed: () async {
                    await saveHTMLfile();
                    Navigator.pop(context);
                  },
                  child: Text('Submit'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
