import 'package:vidsnap/modules/data/video_player/video_player.dart';
import 'package:vidsnap/modules/domain/module.dart';

abstract class AppVideoPlayer implements AppModule<void> {
  AppVideoPlayer._();

  factory AppVideoPlayer.asset(String dataSource) {
    return AppVideoPlayerImpl.asset(dataSource);
  }

  Future<void> initialize();

  Future<void> play();

  Future<void> pause();

  Future<void> dispose();
}
