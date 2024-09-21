import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vidsnap/modules/domain/file_manager/file_manager.dart';

const kRecordingFileDirectory = 'recording';

class AppFileManagerImpl implements AppFileManager {
  @override
  Future<void> bootUp() {
    // TODO: implement bootUp
    throw UnimplementedError();
  }

  @override
  void onBootUp() {
    // TODO: implement onBootUp
  }

  @override
  void bootDown() {
    // TODO: implement bootDown
  }

  @override
  Future<void> listFiles() async {
    final directory = await _getRecordingDirectory();
    directory.list().listen((data) {
      print(data.path);
    });
  }

  Future<Directory> _getRecordingDirectory() async {
    Directory directory = await getApplicationDocumentsDirectory();
    directory = Directory('${directory.path}/$kRecordingFileDirectory');
    await directory.create(recursive: true);

    return directory;
  }

  @override
  Future<String> saveFile(Uint8List bytes) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final dateTime = DateTime.now();
      final path = "${directory.path}/$kRecordingFileDirectory/${dateTime.millisecondsSinceEpoch}.mp4";
      final file = await File(path).create();
      await file.writeAsBytes(bytes);
      return path;
    } catch (error) {
      log('[AppFileManager][saveFile]: Error: $error');
      rethrow;
    }
  }
}
