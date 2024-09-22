part of 'home_bloc.dart';

class HomeState {
  final List<AppRecordedFile> recordedFiles;
  final AppRecordedFile? currentPlayingFile;
  const HomeState({
    required this.recordedFiles,
    required this.currentPlayingFile,
  });

  HomeState.init()
      : this(
          recordedFiles: [],
          currentPlayingFile: null,
        );

  HomeState copyWith({
    List<AppRecordedFile>? recordedFiles,
    AppRecordedFile? currentPlayingFile,
  }) {
    return HomeState(
      recordedFiles: recordedFiles ?? this.recordedFiles,
      currentPlayingFile: currentPlayingFile ?? this.currentPlayingFile,
    );
  }
}
