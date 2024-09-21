part of '../../file_manager.dart';

class AppRecordedVideo {
  final String path;
  final DateTime modified;
  AppRecordedVideo({
    required this.path,
    required this.modified,
  });

  String get name {
    return '${modified.month}_${modified.day}_${modified.year}-${modified.hour}:${modified.minute}';
  }

  String get formattedModifiedDate {
    return '${modified.month}-${modified.day}-${modified.year}';
  }

  String get formattedModifiedTime {
    return '${modified.hour}:${modified.minute}:${modified.second}:${modified.millisecond}';
  }

  factory AppRecordedVideo.fromFileEntity(FileSystemEntity file) {
    final fileName = file.path.toFileName;
    final modified = fileName.toModifiedDate;

    return AppRecordedVideo(
      path: file.path,
      modified: modified,
    );
  }
}

extension on String {
  String get toFileName {
    final fileName = split('/').last;
    return fileName;
  }

  DateTime get toModifiedDate {
    final millisecondsSinceEpoch = split('.mp4').first;
    final createdOn = DateTime.fromMillisecondsSinceEpoch(int.parse(millisecondsSinceEpoch));
    return createdOn;
  }
}
