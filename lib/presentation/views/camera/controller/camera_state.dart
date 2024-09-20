part of 'camera_bloc.dart';

class CameraState {
  final bool isCameraInitialized;
  const CameraState({
    required this.isCameraInitialized,
  });

  CameraState.init() : this(isCameraInitialized: false);

  CameraState copyWith({
    bool? isCameraInitialized,
  }) {
    return CameraState(
      isCameraInitialized: isCameraInitialized ?? this.isCameraInitialized,
    );
  }
}
