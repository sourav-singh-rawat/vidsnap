import 'package:flutter/cupertino.dart';
import 'package:vidsnap/modules/data/video_player/video_player.dart';
import 'package:vidsnap/modules/domain/module.dart';

abstract class AppVideoPlayer implements AppModule<void> {
  AppVideoPlayer._();

  factory AppVideoPlayer.asset(Uri dataSource) {
    return AppVideoPlayerImpl.asset(dataSource);
  }

  Future<void> initialize();

  bool get isInitialized;

  bool get isCompleted;

  bool get isPlaying;

  Duration get position;

  Duration get duration;

  void addListener(VoidCallback listener);

  Future<void> play();

  Future<void> pause();

  Future<void> dispose();

  Widget playerPreview();
}
