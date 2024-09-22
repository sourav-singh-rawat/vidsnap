import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vidsnap/modules/domain/camera/camera.dart';

class AppVidSnapCamera extends StatefulWidget {
  final AppCamera camera;
  const AppVidSnapCamera({
    super.key,
    required this.camera,
  });

  @override
  State<AppVidSnapCamera> createState() => _AppVidSnapCameraState();
}

class _AppVidSnapCameraState extends State<AppVidSnapCamera> {
  DeviceOrientation? orientation;
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return RotatedBox(
          quarterTurns: 1 - widget.camera.sensorOrientation ~/ 90,
          child: widget.camera.cameraPreview(key: widget.key),
        );
      },
    );
  }
}
