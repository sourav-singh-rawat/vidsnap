part of '../view.dart';

class _NoVideoView extends StatelessWidget {
  const _NoVideoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 150,
            width: 150,
            child: FloatingActionButton.large(
              heroTag: kCameraButtonTag,
              onPressed: () => context.read<HomeBloc>().add(OnPressedCameraBtn(context)),
              child: const Icon(
                Icons.camera_enhance_rounded,
                size: 72,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Record Your First Video',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
