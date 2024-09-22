part of '../view.dart';

class _CameraPreview extends StatelessWidget {
  const _CameraPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          alignment: Alignment.center,
          child: BlocSelector<CameraBloc, CameraState, bool>(
            selector: (state) => state.isCameraInitialized,
            builder: (context, isCameraInitialized) {
              if (isCameraInitialized) {
                return AspectRatio(
                  aspectRatio: constraints.maxWidth / constraints.maxHeight,
                  child: BlocSelector<CameraBloc, CameraState, AppCameraLensDirection>(
                    selector: (state) => state.cameraLensDirection,
                    builder: (context, cameraLensDirection) {
                      return AppVidSnapCamera(
                        key: ValueKey(cameraLensDirection.index),
                        camera: AppRepository.camera,
                      );
                    },
                  ),
                );
              }

              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
