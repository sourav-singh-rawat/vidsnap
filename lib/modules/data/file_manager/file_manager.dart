import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vidsnap/modules/domain/file_manager/file_manager.dart';

part 'utils/models/recorded_video.dart';

const kRecordingFileDirectory = 'recording';

class AppFileManagerImpl implements AppFileManager {
  Directory? _recordingDirectory;
  @override
  Future<void> bootUp() async {
    log('[AppFileManager][bootUp]');

    _recordingDirectory = await _getRecordingDirectory();
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
  Future<Directory> get recordingDirectory async {
    _recordingDirectory ??= await _getRecordingDirectory();
    return _recordingDirectory!;
  }

  //TODO: If listSync not working fine then use list
  @override
  List<FileSystemEntity> getFiles(Directory directory) {
    try {
      final data = directory.listSync();
      return data;
    } catch (error) {
      log('[AppFileManager][listFiles]: Error: $error');
      rethrow;
    }
  }

  Future<Directory> _getRecordingDirectory() async {
    Directory directory = await getApplicationDocumentsDirectory();
    directory = Directory('${directory.path}/$kRecordingFileDirectory');
    await directory.create(recursive: true);

    return directory;
  }

  @override
  Future<String> saveFile(Directory directory, Uint8List bytes) async {
    try {
      final dateTime = DateTime.now();
      final path = "${directory.path}/${dateTime.millisecondsSinceEpoch}.mp4";
      final file = await File(path).create();
      await file.writeAsBytes(bytes);
      return path;
    } catch (error) {
      log('[AppFileManager][saveFile]: Error: $error');
      rethrow;
    }
  }
}
