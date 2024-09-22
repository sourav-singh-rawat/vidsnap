import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
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

  @override
  int get sensorOrientation => controller?.description.sensorOrientation ?? 90;

  Future<List<CameraDescription>> _availableCameras() async {
    try {
      final cameras = await availableCameras();
      return cameras;
    } catch (error) {
      log("[AppCamera][_availableCameras]: Error: $error");
      throw Exception('Opps, Failed to detect camera on device');
    }
  }

  Future<CameraController> _initializeCameraController(CameraDescription camera) async {
    try {
      final controller = CameraController(camera, ResolutionPreset.medium);
      await controller.initialize();

      return controller;
    } catch (error) {
      log("[AppCamera][_initializeCameraController]: Error: $error");
      if (error is CameraException) {
        if (error.description == 'NullPointerException') {
          throw SDKInternalException();
        }

        throw Exception(error.description ?? 'Opps, Camera plugin exception, Try Again');
      }
      throw Exception('Opps, Something went wrong, Go Back and Try Again!');
    }
  }

  @override
  Future<AppCameraLensDirection> switchCamera() async {
    try {
      if (deviceAvailableCameras == null) {
        throw Exception('Failed to detect camera on device');
      }

      CameraLensDirection _selectedCameraLens = selectedCameraLens ?? CameraLensDirection.back;
      if (selectedCameraLens == CameraLensDirection.front) {
        _selectedCameraLens = CameraLensDirection.back;
      } else {
        _selectedCameraLens = CameraLensDirection.front;
      }

      controller = await _initializeCameraController(deviceAvailableCameras![_selectedCameraLens.index]);

      selectedCameraLens = _selectedCameraLens;

      _isInitialized = controller?.value.isInitialized ?? false;

      return AppCameraLensDirection.values[_selectedCameraLens.index];
    } catch (error) {
      log("[AppCamera][switchCamera]: Error: $error");
      rethrow;
    }
  }

  @override
  Widget cameraPreview({Key? key}) {
    if (controller == null) {
      return const Offstage();
    }

    return CameraPreview(
      key: key,
      controller!,
    );
  }

  @override
  Future<void> startRecording() async {
    if (controller == null) {
      throw Exception('Turn on the camera.');
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
      throw Exception('Opps, Something went wrong. Video not saved!');
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
  Future<void> lockCaptureOrientation([DeviceOrientation? orientation]) async {
    await controller?.lockCaptureOrientation(orientation);
  }

  @override
  Future<void> unlockCaptureOrientation() async {
    await controller?.unlockCaptureOrientation();
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
