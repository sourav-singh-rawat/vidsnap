part of 'camera_bloc.dart';

sealed class CameraEvent {
  final BuildContext context;
  CameraEvent(this.context);
}

final class InitializeCamera extends CameraEvent {
  InitializeCamera(super.context);
}

final class DisposeCamera extends CameraEvent {
  DisposeCamera(super.context);
}
