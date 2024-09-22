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
          child: BlocBuilder<CameraBloc, CameraState>(
            builder: (context, state) {
              if (state.isCameraInitialized) {
                return AspectRatio(
                  aspectRatio: constraints.maxWidth / constraints.maxHeight,
                  child: AppVidSnapCamera(
                    key: ValueKey(state.cameraLensDirection.index),
                    camera: AppRepository.camera,
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
