import 'dart:async';
import 'dart:typed_data';
import 'package:kurikulumsmk/repository/fs_repository.dart';
import 'package:rxdart/rxdart.dart';

class FileServerBloc {
  final FileServerRepository fileServerRepo;

  // Loaded data
  ByteData fileData = ByteData(0);

  // Data Streams
  Stream<String> _content = Stream.empty();
  Stream<String> _log = Stream.empty();

  Stream<String> get log => _log;
  Stream<String> get content => _content;

  // Input sink
  ReplaySubject<String> _downloadFile = ReplaySubject<String>();

  Sink<String> get downloadFile => _downloadFile;

  FileServerBloc(this.fileServerRepo) {
    _content = _downloadFile.asyncMap(fileServerRepo.downloadFile).asBroadcastStream();

    _log = Observable(_content)
        .withLatestFrom(_downloadFile.stream, (_, e) => 'Results for $e')
        .asBroadcastStream();
  }

  void dispose() {
    _downloadFile.close();
  }

  void reset() {
    fileData = ByteData(0);
  }
}