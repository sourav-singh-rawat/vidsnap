part of '../../view.dart';

class _VideoTile extends StatelessWidget {
  final AppRecordedFile file;

  const _VideoTile({
    super.key,
    required this.file,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, AppRecordedFile?>(
      selector: (state) => state.currentPlayingFile,
      builder: (context, currentPlayingFile) {
        final isSelected = currentPlayingFile?.path == file.path;
        return AppClickable(
          onPressed: () {
            context.read<HomeBloc>().add(OnPressedVideoTile(context, file: file));
          },
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected ? Colors.deepPurpleAccent : Colors.white,
                width: 1,
              ),
              color: isSelected ? Colors.deepPurpleAccent.withOpacity(0.05) : Colors.white,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppVideoThumbnail(
                  dataSource: file.uri,
                  width: 150,
                  height: 80,
                  borderRadius: 8,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 20),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      file.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Date: ${file.formattedModifiedDate}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      'Time: ${file.formattedModifiedTime}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
