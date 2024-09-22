part of '../view.dart';

class _CameraPreview extends StatelessWidget {
  const _CameraPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: BlocSelector<CameraBloc, CameraState, bool>(
            selector: (state) => state.isCameraInitialized,
            builder: (context, isCameraInitialized) {
              if (isCameraInitialized) {
                return AppVidSnapCamera(camera: AppRepository.camera);
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
