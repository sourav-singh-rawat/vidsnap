part of '../../file_manager.dart';

class AppRecordedFile {
  final String path;
  final Uri uri;
  final DateTime modified;
  AppRecordedFile({
    required this.path,
    required this.uri,
    required this.modified,
  });

  String get name {
    return '${modified.month}_${modified.day}_${modified.year}-${modified.hour}_${modified.minute}_${modified.second}';
  }

  String get formattedModifiedDate {
    return '${modified.month}-${modified.day}-${modified.year}';
  }

  String get formattedModifiedTime {
    return '${modified.hour}:${modified.minute}:${modified.second}:${modified.millisecond}';
  }

  factory AppRecordedFile.fromFileEntity(FileSystemEntity file) {
    final fileName = file.path.toFileName;
    final modified = fileName.toModifiedDate;

    return AppRecordedFile(
      path: file.path,
      uri: file.uri,
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
