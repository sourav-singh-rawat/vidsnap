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

final class OnPressedBack extends CameraEvent {
  OnPressedBack(super.context);
}

final class SwitchCameraLens extends CameraEvent {
  SwitchCameraLens(super.context);
}

final class OnPressedRecordingBtn extends CameraEvent {
  OnPressedRecordingBtn(super.context);
}
