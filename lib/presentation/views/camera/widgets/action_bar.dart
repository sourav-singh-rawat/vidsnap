part of '../view.dart';

class _ActionBar extends StatelessWidget {
  const _ActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CameraBloc, CameraState, bool>(
      selector: (state) => state.isCameraInitialized,
      builder: (context, isCameraInitialized) {
        if (isCameraInitialized) {
          return Container(
            color: Colors.white.withOpacity(0.025),
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _RecordingPreview(),
                _RecordingActionButton(),
                _SwitchCameraLensButton(),
              ],
            ),
          );
        }

        return const Offstage();
      },
    );
  }
}

class _RecordingPreview extends StatelessWidget {
  const _RecordingPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CameraBloc, CameraState, Uri?>(
      selector: (state) => state.recentRecordedVideoUri,
      builder: (context, recentRecordedVideoUri) {
        if (recentRecordedVideoUri == null) {
          return const SizedBox(width: 84);
        }

        return AppClickable(
          onPressed: () => context.read<CameraBloc>().add(OnPressedBack(context)),
          child: AppVideoThumbnail(
            width: 84,
            height: 60,
            dataSource: recentRecordedVideoUri,
            borderRadius: 8,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}

class _RecordingActionButton extends StatelessWidget {
  const _RecordingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 84,
      child: AppClickable(
        onPressed: () => context.read<CameraBloc>().add(OnPressedRecordingBtn(context)),
        child: BlocSelector<CameraBloc, CameraState, bool>(
          selector: (state) => state.isRecording,
          builder: (context, isRecording) {
            return CircleAvatar(
              backgroundColor: isRecording ? Colors.redAccent : Colors.white,
              radius: 42,
              child: const CircleAvatar(
                backgroundColor: Colors.redAccent,
                radius: 24,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SwitchCameraLensButton extends StatelessWidget {
  const _SwitchCameraLensButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppClickable(
      onPressed: () => context.read<CameraBloc>().add(SwitchCameraLens(context)),
      child: SizedBox(
        width: 84,
        child: CircleAvatar(
          radius: 24,
          backgroundColor: Colors.white.withOpacity(0.1),
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.cameraswitch_outlined,
              size: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
