import 'package:vidsnap/modules/domain/camera/camera.dart';
import 'package:vidsnap/modules/domain/file_manager/file_manager.dart';

class AppRepository {
  AppRepository._();

  static final camera = AppCamera();
  static final fileManager = AppFileManager();

  //TODO: can use factory to include video player
}
