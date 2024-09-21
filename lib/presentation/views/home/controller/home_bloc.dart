import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vidsnap/modules/data/file_manager/file_manager.dart';
import 'package:vidsnap/modules/domain/router/router.dart';
import 'package:vidsnap/presentation/views/camera/view.dart';
import 'package:vidsnap/repository/repository.dart';
import 'package:vidsnap/utils/app_services/app_services.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.init()) {
    on<FetchRecordedFiles>(_onFetchRecordedFiles);
    on<OnPressedCameraBtn>(_onPressedCameraBtn);
  }

  void _onFetchRecordedFiles(FetchRecordedFiles event, Emitter<HomeState> emit) async {
    try {
      final recordingDirectory = await AppRepository.fileManager.recordingDirectory;
      final files = AppRepository.fileManager.getFiles(recordingDirectory);

      final data = files.map((v) => AppRecordedVideo.fromFileEntity(v)).toList();

      emit.call(state.copyWith(
        recordedVideos: data,
      ));
    } catch (error) {
      AppService.snack.show(context: event.context, text: error.toString());
    }
  }

  void _onPressedCameraBtn(OnPressedCameraBtn event, Emitter<HomeState> emit) async {
    await AppRouter.instance.push(event.context, const CameraView());

    add(FetchRecordedFiles(event.context));
  }
}
