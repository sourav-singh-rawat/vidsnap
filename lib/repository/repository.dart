import 'package:vidsnap/modules/domain/camera/camera.dart';
import 'package:vidsnap/modules/domain/file_manager/file_manager.dart';

class AppRepository {
  AppRepository._();

  static final camera = AppCamera.instance;
  static final fileManager = AppFileManager();
}
