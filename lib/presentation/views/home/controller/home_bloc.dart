import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vidsnap/modules/data/file_manager/file_manager.dart';
import 'package:vidsnap/modules/domain/router/router.dart';
import 'package:vidsnap/modules/domain/video_player/video_player.dart';
import 'package:vidsnap/presentation/views/camera/view.dart';
import 'package:vidsnap/repository/repository.dart';
import 'package:vidsnap/utils/app_services/app_services.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.init()) {
    on<FetchRecordedFiles>(_onFetchRecordedFiles);
    on<OnPressedCameraBtn>(_onPressedCameraBtn);
    on<OnPressedVideoTile>(_onPressedVideoTile);
  }

  AppVideoPlayer? player;

  void _onFetchRecordedFiles(FetchRecordedFiles event, Emitter<HomeState> emit) async {
    try {
      final recordingDirectory = await AppRepository.fileManager.recordingDirectory;
      final files = AppRepository.fileManager.getFiles(recordingDirectory);

      final videoFiles = files.map((v) => AppRecordedFile.fromFileEntity(v)).toList();
      videoFiles.sort((a, b) => b.modified.compareTo(a.modified));

      if (videoFiles.isNotEmpty) {
        //TODO: handle if already playing a video
        //TODO: check position
        await _initializePlayer(videoFiles[0].uri);
      }

      emit.call(state.copyWith(
        recordedFiles: videoFiles,
        currentPlayingFile: videoFiles.isNotEmpty ? videoFiles[0] : null,
      ));
    } catch (error) {
      AppService.snack.show(context: event.context, text: error.toString());
    }
  }

  void _onPressedCameraBtn(OnPressedCameraBtn event, Emitter<HomeState> emit) async {
    await player?.pause();

    final recentRecordedVideoUri = await AppRouter.instance.push<Uri?>(event.context, const CameraView());

    // if (recentRecordedVideoUri != null) {
    add(FetchRecordedFiles(event.context));
    // }
  }

  void _onPressedVideoTile(OnPressedVideoTile event, Emitter<HomeState> emit) async {
    await _initializePlayer(event.file.uri);

    emit.call(state.copyWith(
      currentPlayingFile: event.file,
    ));
  }

  Future<void> _initializePlayer(Uri uri) async {
    await player?.pause();
    player = AppVideoPlayer.asset(uri);
    await player?.initialize();
  }
}
