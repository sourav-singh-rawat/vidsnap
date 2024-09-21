import 'package:vidsnap/modules/domain/camera/camera.dart';

class AppRepository {
  AppRepository._();

  static final camera = AppCamera.instance;
}
