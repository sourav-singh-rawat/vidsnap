part of 'camera_bloc.dart';

class CameraState {
  final bool isCameraInitialized;
  final bool isRecording;
  final Uri? recentRecordedVideoUri;
  final AppCameraLensDirection cameraLensDirection;
  const CameraState({
    required this.isCameraInitialized,
    required this.isRecording,
    this.recentRecordedVideoUri,
    required this.cameraLensDirection,
  });

  CameraState.init()
      : this(
            isCameraInitialized: false,
            isRecording: false,
            recentRecordedVideoUri: null,
            cameraLensDirection: AppCameraLensDirection.back);

  CameraState copyWith({
    bool? isCameraInitialized,
    bool? isRecording,
    Uri? recentRecordedVideoUri,
    AppCameraLensDirection? cameraLensDirection,
  }) {
    return CameraState(
      isCameraInitialized: isCameraInitialized ?? this.isCameraInitialized,
      isRecording: isRecording ?? this.isRecording,
      recentRecordedVideoUri: recentRecordedVideoUri ?? this.recentRecordedVideoUri,
      cameraLensDirection: cameraLensDirection ?? this.cameraLensDirection,
    );
  }
}
