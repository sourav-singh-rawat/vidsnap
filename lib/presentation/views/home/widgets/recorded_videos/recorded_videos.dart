part of '../../view.dart';

class _RecordedVideos extends StatelessWidget {
  const _RecordedVideos({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocSelector<HomeBloc, HomeState, List<AppRecordedFile>>(
        selector: (state) => state.recordedFiles,
        builder: (context, files) {
          return ListView.builder(
            itemCount: files.length,
            itemBuilder: (BuildContext context, int index) {
              return _VideoTile(
                file: files[index],
              );
            },
          );
        },
      ),
    );
  }
}
