part of '../view.dart';

class _VideoPlayer extends StatelessWidget {
  const _VideoPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, AppRecordedFile?>(
      selector: (state) => state.currentPlayingFile,
      builder: (context, currentPlayingFile) {
        if (currentPlayingFile == null) {
          return Container(
            width: double.maxFinite,
            height: 250,
            color: Colors.black,
            child: const Center(
              child: Icon(
                Icons.error_outline,
                size: 250 / 4,
                color: Colors.white,
              ),
            ),
          );
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
