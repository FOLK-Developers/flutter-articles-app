import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> localPath() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<Directory> userArticlePath() async {
  final String _localPath = await localPath();
  final Directory _userPath = Directory('$_localPath/user_article/');
  if (_userPath.existsSync()) return _userPath;
  _userPath.createSync(recursive: true);
  return _userPath;
}

Future<Directory> dbArticlePath() async {
  final String _localPath = await localPath();
  final Directory _dbPath = Directory('$_localPath/db_article/');
  if (_dbPath.existsSync()) return _dbPath;
  _dbPath.createSync(recursive: true);
  return _dbPath;
}
