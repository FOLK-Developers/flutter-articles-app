import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:hive/hive.dart';
import 'package:html_sample/filepath.dart';
import 'package:html_sample/screens/editarticle.dart';

import 'viewarticle.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // var articleBox;
  // @override
  // void initState() {
  //   initHive();
  //   super.initState();
  // }

  // initHive() async {
  //   Hive.init(await localPath());
  //   articleBox = await Hive.openBox('testBox');
  // }
  Future<List<String>> listOfFilesinDb() async {
    List<String> fileList = [];
    await dbArticlePath().then((dir) {
      dir.listSync().forEach((file) {
        fileList.add(file.path);
      });
      print(fileList);
    });
    return fileList;
  }

  Future<List<String>> listOfFilesinUser() async {
    List<String> fileList = [];
    await userArticlePath().then((dir) {
      dir.listSync().forEach((file) {
        fileList.add(file.path);
      });
      print(fileList);
    });
    return fileList;
  }

  deleteFile(String path) async {
    File fileToDelete = File(path);
    fileToDelete.deleteSync(recursive: true);
  }

  @override
  Widget build(BuildContext context) {
    //listOfFilesinDb();

    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: listOfFilesinUser(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                    break;
                  case ConnectionState.done:
                    List<String> filespath = snapshot.data;
                    List<Widget> articleCards = [];
                    filespath.forEach((filepath) {
                      articleCards.add(Card(
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewArticle(
                                        filePath: filepath,
                                      ))),
                          child: Column(
                            children: [
                              Image(
                                image: NetworkImage(
                                    'https://picsum.photos/200/300'),
                              ),
                              Text('$filepath'),
                            ],
                          ),
                        ),
                      ));
                    });
                    return Column(
                      children: articleCards,
                    );
                    break;
                  default:
                    return CircularProgressIndicator();
                }
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => EditArticle())),
        child: Icon(Icons.add),
      ),
    );
  }
}
