import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:vidsnap/modules/domain/video_player/video_player.dart';

class AppVideoPlayerImpl implements AppVideoPlayer {
  AppVideoPlayerImpl._();

  late VideoPlayerController controller;

  AppVideoPlayerImpl.asset(Uri dataSource) {
    controller = VideoPlayerController.contentUri(
      dataSource,
    );
  }

  @override
  Future<void> bootUp() {
    // TODO: implement bootUp
    throw UnimplementedError();
  }

  @override
  void onBootUp() {
    // TODO: implement onBootUp
  }
  @override
  void bootDown() {
    // TODO: implement bootDown
  }

  @override
  Future<void> initialize() async {
    await controller.initialize();
  }

  @override
  bool get isInitialized => controller.value.isInitialized;

  @override
  Future<void> play() async {
    await controller.play();
  }

  @override
  Future<void> pause() async {
    await controller.pause();
  }

  @override
  Widget playerPreview() {
    return VideoPlayer(controller);
  }

  @override
  Future<void> dispose() async {
    await controller.dispose();
  }
}
