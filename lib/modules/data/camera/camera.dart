import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:vidsnap/modules/domain/camera/camera.dart';
import 'package:vidsnap/repository/repository.dart';
import 'package:vidsnap/utils/helper.dart';

part 'utils/helper.dart';

class AppCameraImpl implements AppCamera {
  bool _isInitialized = false;
  List<CameraDescription>? deviceAvailableCameras;
  CameraController? controller;
  CameraLensDirection? selectedCameraLens;

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
  Future<bool> initialize() async {
    try {
      if (controller != null) {
        return true;
      }

      deviceAvailableCameras = await _availableCameras();
      if (deviceAvailableCameras != null && deviceAvailableCameras!.isNotEmpty) {
        controller = await _initializeCameraController(deviceAvailableCameras![0]);

        selectedCameraLens = deviceAvailableCameras![0].lensDirection;

        _isInitialized = controller?.value.isInitialized ?? false;
      }

      return _isInitialized;
    } catch (error) {
      log("[AppCamera][_availableCameras]: Error");
      rethrow;
    }
  }

  @override
  bool get isInitialized => _isInitialized;

  Future<List<CameraDescription>> _availableCameras() async {
    try {
      final cameras = await availableCameras();
      return cameras;
    } catch (error) {
      log("[AppCamera][_availableCameras]: Error: $error");
      throw ErrorDescription('Opps, Failed to detect camera on device');
    }
  }

  Future<CameraController> _initializeCameraController(CameraDescription camera) async {
    try {
      final controller = CameraController(camera, ResolutionPreset.max);
      await controller.initialize();

      return controller;
    } catch (error) {
      log("[AppCamera][_initializeCameraController]: Error: $error");
      if (error is CameraException) {
        if (error.description == 'NullPointerException') {
          throw SDKInternalException();
        }

        throw ErrorDescription(error.description ?? 'Opps, Camera plugin exception, Try Again');
      }
      throw ErrorDescription('Opps, Something went wrong, Go Back and Try Again!');
    }
  }

  @override
  Future<void> switchCamera() async {
    try {
      if (deviceAvailableCameras == null) {
        throw ErrorDescription('Failed to detect camera on device');
      }

      CameraLensDirection _selectedCameraLens = selectedCameraLens ?? CameraLensDirection.front;
      if (selectedCameraLens == CameraLensDirection.front) {
        _selectedCameraLens = CameraLensDirection.back;
      } else {
        _selectedCameraLens = CameraLensDirection.front;
      }

      controller = await _initializeCameraController(deviceAvailableCameras![_selectedCameraLens.index]);

      selectedCameraLens = _selectedCameraLens;

      _isInitialized = controller?.value.isInitialized ?? false;
    } catch (error) {
      log("[AppCamera][switchCamera]: Error: $error");
      rethrow;
    }
  }

  @override
  Widget cameraPreview() {
    if (controller == null) {
      return const Offstage();
    }

    return CameraPreview(controller!);
  }

  @override
  Future<void> startRecording() async {
    if (controller == null) {
      throw ErrorDescription('Turn on the camera.');
    }

    try {
      await controller!.prepareForVideoRecording();
      await controller!.startVideoRecording();
    } catch (error) {
      log("[AppCamera][startRecording]: Error: $error");
      rethrow;
    }
  }

  @override
  Future<Uri> stopRecording() async {
    if (controller == null) {
      throw ErrorDescription('Opps, Something went wrong. Video not saved!');
    }
    try {
      final video = await controller!.stopVideoRecording();
      final bytes = await video.readAsBytes();

      final recordingDirectory = await AppRepository.fileManager.recordingDirectory;

      final uri = await AppRepository.fileManager.saveFile(recordingDirectory, bytes);
      return uri;
    } catch (error) {
      log("[AppCamera][stopRecording]: Error: $error");
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    try {
      await controller?.dispose();
      controller = null;
      deviceAvailableCameras = null;
      selectedCameraLens = null;
      _isInitialized = false;
    } catch (error) {
      log("[AppCamera][dispose]: Error: $error");
      rethrow;
    }
  }
}
