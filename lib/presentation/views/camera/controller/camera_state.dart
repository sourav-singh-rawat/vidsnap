part of 'camera_bloc.dart';

class CameraState {
  final bool isCameraInitialized;
  final bool isRecording;
  final Uri? recentRecordedVideoUri;
  const CameraState({
    required this.isCameraInitialized,
    required this.isRecording,
    this.recentRecordedVideoUri,
  });

  CameraState.init()
      : this(
          isCameraInitialized: false,
          isRecording: false,
          recentRecordedVideoUri: null,
        );

  CameraState copyWith({
    bool? isCameraInitialized,
    bool? isRecording,
    Uri? recentRecordedVideoUri,
  }) {
    return CameraState(
      isCameraInitialized: isCameraInitialized ?? this.isCameraInitialized,
      isRecording: isRecording ?? this.isRecording,
      recentRecordedVideoUri: recentRecordedVideoUri ?? this.recentRecordedVideoUri,
    );
  }
}
