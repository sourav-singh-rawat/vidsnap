import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vidsnap/modules/domain/camera/camera.dart';
import 'package:vidsnap/presentation/core_widgets/snack_bar.dart';

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
      if (state.isRecording) {
        await _stopRecording(emit);
      }

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

  void _onPressedRecordingBtn(OnPressedRecordingBtn event, Emitter<CameraState> emit) async {
    try {
      if (state.isRecording) {
        await _stopRecording(emit);
      } else {
        await _startRecording(emit);
      }
    } catch (error) {
      AppSnack.show(context: event.context, text: error.toString());
    }
  }

  Future<void> _startRecording(Emitter<CameraState> emit) async {
    try {
      await AppCamera.instance.startRecording();

      emit.call(state.copyWith(
        isRecording: true,
      ));
    } catch (error) {
      rethrow;
    }
  }

  Future<void> _stopRecording(Emitter<CameraState> emit) async {
    try {
      final videoPath = await AppCamera.instance.stopRecording();
      //TODO: show preview with this path

      emit.call(state.copyWith(
        isRecording: false,
      ));
    } catch (error) {
      rethrow;
    }
  }
}
