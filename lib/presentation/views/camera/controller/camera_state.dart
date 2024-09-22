part of 'camera_bloc.dart';

class CameraState {
  final bool isCameraInitialized;
  final bool isRecording;
  final String? recordedVideoPath;
  const CameraState({
    required this.isCameraInitialized,
    required this.isRecording,
    this.recordedVideoPath,
  });

  CameraState.init()
      : this(
          isCameraInitialized: false,
          isRecording: false,
          recordedVideoPath: null,
        );

  CameraState copyWith({
    bool? isCameraInitialized,
    bool? isRecording,
    String? recordedVideoPath,
  }) {
    return CameraState(
      isCameraInitialized: isCameraInitialized ?? this.isCameraInitialized,
      isRecording: isRecording ?? this.isRecording,
      recordedVideoPath: recordedVideoPath ?? this.recordedVideoPath,
    );
  }
}
