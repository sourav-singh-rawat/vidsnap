import 'package:flutter/material.dart';
import 'package:vidsnap/modules/data/camera/camera.dart';
import 'package:vidsnap/modules/domain/module.dart';

abstract class AppCamera implements AppModule<void> {
  AppCamera._();

  static final AppCameraImpl instance = AppCameraImpl();

  factory AppCamera() {
    return instance;
  }

  Future<bool> initialize();

  bool get isInitialized;

  Future<void> switchCamera();

  Future<void> startRecording();

  Future<Uri> stopRecording();

  Widget cameraPreview();

  Future<void> dispose();
}
