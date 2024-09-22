import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vidsnap/modules/domain/router/router.dart';
import 'package:vidsnap/repository/repository.dart';
import 'package:vidsnap/utils/app_services/app_services.dart';

part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(CameraState.init()) {
    on<InitializeCamera>(_initializeCamera);
    on<DisposeCamera>(_disposeCamera);
    on<SwitchCameraLens>(_switchCameraLens);
    on<OnPressedRecordingBtn>(_onPressedRecordingBtn);
    on<OnPressedBack>(_onPressedBack);
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
      isInitialized = await AppRepository.camera.initialize();
    } catch (error) {
      AppService.snack.show(context: event.context, text: error.toString());
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

      await AppRepository.camera.dispose();

      emit.call(state.copyWith(
        isCameraInitialized: false,
        isRecording: false,
      ));
    } catch (error) {
      AppService.snack.show(context: event.context, text: error.toString());
    }
  }

  void _switchCameraLens(SwitchCameraLens event, Emitter<CameraState> emit) async {
    try {
      await AppRepository.camera.switchCamera();
    } catch (error) {
      AppService.snack.show(context: event.context, text: error.toString());
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
      AppService.snack.show(context: event.context, text: error.toString());
    }
  }

  Future<void> _startRecording(Emitter<CameraState> emit) async {
    try {
      await AppRepository.camera.startRecording();

      emit.call(state.copyWith(
        isRecording: true,
      ));
    } catch (error) {
      rethrow;
    }
  }

  Future<void> _stopRecording(Emitter<CameraState> emit) async {
    try {
      final recentRecordedVideoUri = await AppRepository.camera.stopRecording();

      emit.call(state.copyWith(
        isRecording: false,
        recentRecordedVideoUri: recentRecordedVideoUri,
      ));
    } catch (error) {
      rethrow;
    }
  }

  void _onPressedBack(OnPressedBack event, Emitter<CameraState> emit) {
    AppRouter.instance.pop(event.context, state.recentRecordedVideoUri);

    emit.call(CameraState(
      isCameraInitialized: state.isCameraInitialized,
      isRecording: false,
    ));
  }
}
