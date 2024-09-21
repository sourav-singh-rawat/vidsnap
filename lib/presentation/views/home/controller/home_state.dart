part of 'home_bloc.dart';

class HomeState {
  final List<AppRecordedVideo> recordedVideos;
  const HomeState({
    required this.recordedVideos,
  });

  HomeState.init()
      : this(
          recordedVideos: [],
        );

  HomeState copyWith({
    List<AppRecordedVideo>? recordedVideos,
  }) {
    return HomeState(
      recordedVideos: recordedVideos ?? this.recordedVideos,
    );
  }
}
