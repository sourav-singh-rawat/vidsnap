import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vidsnap/modules/domain/camera/camera.dart';
import 'package:vidsnap/utils/services/snack_bar.dart';

part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(CameraState.init()) {
    on<InitializeCamera>(_initializeCamera);
    on<DisposeCamera>(_disposeCamera);
    on<SwitchCameraLens>(_switchCameraLens);
    on<OnPressedRecordingBtn>(_onPressedRecordingBtn);
  }

  void _initializeCamera(InitializeCamera event, Emitter<CameraState> emit) async {
    if (state.isCameraInitialized) {
      emit.call(state.copyWith(
        isCameraInitialized: false,
        isRecording: false,
      ));
    }

    bool isInitialized = false;

    try {
      isInitialized = await AppCamera.instance.initialize();
    } catch (error) {
      AppSnack.show(context: event.context, text: error.toString());
    }

    emit.call(state.copyWith(
      isCameraInitialized: isInitialized,
      isRecording: false,
    ));
  }

  void _disposeCamera(DisposeCamera event, Emitter<CameraState> emit) async {
    try {
      await AppCamera.instance.dispose();

      emit.call(state.copyWith(
        isCameraInitialized: false,
        isRecording: false,
      ));
    } catch (error) {
      AppSnack.show(context: event.context, text: error.toString());
    }
  }

  void _switchCameraLens(SwitchCameraLens event, Emitter<CameraState> emit) async {
    try {
      await AppCamera.instance.switchCamera();
    } catch (error) {
      AppSnack.show(context: event.context, text: error.toString());
    }
  }

  void _onPressedRecordingBtn(OnPressedRecordingBtn event, Emitter<CameraState> emit) {
    emit.call(state.copyWith(
      isRecording: !state.isRecording,
    ));
  }
}
