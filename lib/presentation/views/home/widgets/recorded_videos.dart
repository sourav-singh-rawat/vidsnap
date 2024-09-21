part of '../view.dart';

class _RecordedVideos extends StatelessWidget {
  const _RecordedVideos({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocSelector<HomeBloc, HomeState, List<AppRecordedVideo>>(
        selector: (state) => state.recordedVideos,
        builder: (context, recordedVideos) {
          return ListView.builder(
            itemCount: recordedVideos.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Text(recordedVideos[index].name),
              );
            },
          );
        },
      ),
    );
  }
}
