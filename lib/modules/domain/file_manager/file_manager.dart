import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:vidsnap/modules/data/file_manager/file_manager.dart';
import 'package:vidsnap/modules/domain/module.dart';

abstract class AppFileManager implements AppModule<void> {
  AppFileManager._();

  static final AppFileManager instance = AppFileManagerImpl();

  factory AppFileManager() {
    return instance;
  }

  Future<Directory> get recordingDirectory;

  List<FileSystemEntity> getFiles(Directory directory);

  Future<Uri> saveFile(Directory directory, Uint8List bytes);
}
