part of 'camera_bloc.dart';

class CameraState {
  final bool isCameraInitialized;
  final bool isRecording;
  const CameraState({
    required this.isCameraInitialized,
    required this.isRecording,
  });

  CameraState.init()
      : this(
          isCameraInitialized: false,
          isRecording: false,
        );

  CameraState copyWith({
    bool? isCameraInitialized,
    bool? isRecording,
  }) {
    return CameraState(
      isCameraInitialized: isCameraInitialized ?? this.isCameraInitialized,
      isRecording: isRecording ?? this.isRecording,
    );
  }
}
