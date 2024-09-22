part of '../view.dart';

class _VideoPlayer extends StatelessWidget {
  const _VideoPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, AppRecordedFile?>(
      selector: (state) => state.currentPlayingFile,
      builder: (context, currentPlayingFile) {
        if (currentPlayingFile == null) {
          return const _VideoPlayerLoading();
        }

        return AppVidSnapPlayer(
          key: ValueKey(currentPlayingFile.path),
          width: double.maxFinite,
          height: 250,
          player: context.read<HomeBloc>().player,
        );
      },
    );
  }
}

class _VideoPlayerLoading extends StatelessWidget {
  const _VideoPlayerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    const iconSize = 250 / 4;

    return Container(
      width: double.maxFinite,
      height: 250,
      color: Colors.black,
      child: const Center(
        child: SizedBox(
          width: iconSize,
          height: iconSize,
          child: CircularProgressIndicator(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
