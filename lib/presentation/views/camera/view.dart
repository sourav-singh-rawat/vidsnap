import 'package:flutter/material.dart';
import 'package:vidsnap/presentation/core_widgets/scaffold.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: Center(
        child: Text('Camera View'),
      ),
    );
  }
}
