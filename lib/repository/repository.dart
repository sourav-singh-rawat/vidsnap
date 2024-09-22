import 'package:vidsnap/modules/domain/camera/camera.dart';
import 'package:vidsnap/modules/domain/file_manager/file_manager.dart';

class AppRepository {
  AppRepository._();

  //TODO: change to AppCamera
  static final camera = AppCamera.instance;
  static final fileManager = AppFileManager();

  //TODO: can use factory to include video player
}
