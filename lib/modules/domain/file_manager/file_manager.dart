import 'package:flutter/foundation.dart';
import 'package:vidsnap/modules/data/file_manager/file_manager.dart';
import 'package:vidsnap/modules/domain/module.dart';

abstract class AppFileManager implements AppModule<void> {
  AppFileManager._();

  static final AppFileManager instance = AppFileManagerImpl();

  factory AppFileManager() {
    return instance;
  }

  Future<void> listFiles();
  Future<void> saveFile(Uint8List bytes);
}
