part of 'home_bloc.dart';

class HomeState {
  final List<AppRecordedFile> recordedFiles;
  const HomeState({
    required this.recordedFiles,
  });

  HomeState.init()
      : this(
          recordedFiles: [],
        );

  HomeState copyWith({
    List<AppRecordedFile>? recordedVideos,
  }) {
    return HomeState(
      recordedFiles: recordedVideos ?? this.recordedFiles,
    );
  }
}
