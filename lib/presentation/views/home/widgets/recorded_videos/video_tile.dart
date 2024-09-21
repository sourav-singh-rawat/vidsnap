part of '../../view.dart';

class _VideoTile extends StatelessWidget {
  final AppRecordedFile recordedFile;
  const _VideoTile({
    super.key,
    required this.recordedFile,
  });

  @override
  Widget build(BuildContext context) {
    return AppClickable(
      onPressed: () {},
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ).copyWith(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 150,
            height: 80,
            color: Colors.black,
          ),
          const SizedBox(width: 24),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                recordedFile.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Date: ${recordedFile.formattedModifiedDate}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              Text(
                'Time: ${recordedFile.formattedModifiedTime}',
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
