import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vidsnap/modules/domain/file_manager/file_manager.dart';

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
  Future<void> listFiles() {
    // TODO: implement listFiles
    throw UnimplementedError();
  }

  @override
  Future<void> saveFile(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/xyz.mp4";
    final file = await File(path).create();
    file.writeAsBytesSync(bytes);
  }
}
