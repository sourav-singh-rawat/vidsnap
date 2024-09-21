part of '../view.dart';

class _CameraButton extends StatelessWidget {
  const _CameraButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => context.read<HomeBloc>().add(OnPressedCameraBtn(context)),
      child: const Icon(
        Icons.camera_enhance_rounded,
        size: 24,
      ),
    );
  }
}
