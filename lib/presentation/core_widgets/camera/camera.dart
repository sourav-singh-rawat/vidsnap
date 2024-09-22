import 'package:flutter/material.dart';
import 'package:vidsnap/modules/domain/camera/camera.dart';

class AppVidSnapCamera extends StatelessWidget {
  final AppCamera camera;
  const AppVidSnapCamera({
    super.key,
    required this.camera,
  });

  @override
  Widget build(BuildContext context) {
    return camera.cameraPreview();
  }
}
