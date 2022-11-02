import 'package:equatable/equatable.dart';

class FileInfo extends Equatable {
  final String fileName;
  final String fileUrl;
  final double progress;

  const FileInfo({
    required this.fileName,
    required this.fileUrl,
    required this.progress,
  });

  FileInfo copyWith({
    String? fileName,
    String? fileUrl,
    double? progress,
  }) =>
      FileInfo(
        fileName: fileName ?? this.fileName,
        fileUrl: fileUrl ?? this.fileUrl,
        progress: progress ?? this.progress,
      );

  @override
  List<Object?> get props => [
    fileName,
    fileUrl,
    progress,
  ];
}