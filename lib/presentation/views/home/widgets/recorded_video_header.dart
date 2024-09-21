part of '../view.dart';

class _RecordedVideosHeader extends StatelessWidget {
  const _RecordedVideosHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: BlocSelector<HomeBloc, HomeState, List<AppRecordedFile>>(
        selector: (state) => state.recordedFiles,
        builder: (context, recordedFiles) {
          return Text(
            'Recorded Videos (${recordedFiles.length})',
          );
        },
      ),
    );
  }
}
