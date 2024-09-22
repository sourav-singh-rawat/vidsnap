part of '../../view.dart';

class _VideoTile extends StatelessWidget {
  final AppRecordedFile file;
  const _VideoTile({
    super.key,
    required this.file,
  });

  @override
  Widget build(BuildContext context) {
    return AppClickable(
      onPressed: () {
        context.read<HomeBloc>().add(OnPressedVideoTile(context, file: file));
      },
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ).copyWith(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppVideoThumbnail(
            dataSource: file.uri,
            width: 150,
            height: 80,
            borderRadius: 8,
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
              ),
              const SizedBox(height: 8),
              Text(
                'Date: ${file.formattedModifiedDate}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              Text(
                'Time: ${file.formattedModifiedTime}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
