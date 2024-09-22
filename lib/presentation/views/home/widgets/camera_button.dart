part of '../view.dart';

class _CameraButton extends StatelessWidget {
  const _CameraButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, List<AppRecordedFile>>(
      selector: (state) => state.recordedFiles,
      builder: (context, recordedFiles) {
        final hasRecordedFiles = recordedFiles.isNotEmpty;
        if (!hasRecordedFiles) {
          return const Offstage();
        }

        return FloatingActionButton(
          heroTag: kCameraButtonTag,
          onPressed: () => context.read<HomeBloc>().add(OnPressedCameraBtn(context)),
          child: const Icon(
            Icons.camera_enhance_rounded,
            size: 24,
          ),
        );
      },
    );
  }
}
