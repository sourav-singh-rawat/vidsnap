import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vidsnap/modules/domain/camera/camera.dart';
import 'package:vidsnap/modules/domain/router/router.dart';
import 'package:vidsnap/presentation/core_widgets/scaffold.dart';
import 'package:vidsnap/presentation/views/camera/controller/camera_bloc.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<CameraBloc>().add(InitializeCamera(context));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (!mounted) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      context.read<CameraBloc>().add(DisposeCamera(context));
    } else if (state == AppLifecycleState.resumed) {
      context.read<CameraBloc>().add(InitializeCamera(context));
    }
  }

  @override
  void deactivate() {
    context.read<CameraBloc>().add(DisposeCamera(context));
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => AppRouter.instance.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 24,
            color: Colors.white,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: BlocSelector<CameraBloc, CameraState, bool>(
              selector: (state) => state.isCameraInitialized,
              builder: (context, isCameraInitialized) {
                if (isCameraInitialized) {
                  return AppCamera.instance.cameraPreview();
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          );
        },
      ),
      bottomSheet: Container(
        color: Colors.white.withOpacity(0.05),
        width: double.maxFinite,
        child: Row(
          children: [],
        ),
      ),
    );
  }
}
