import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:kurikulumsmk/config.dart';
import 'package:dio/dio.dart';
import 'package:kurikulumsmk/utils/text.dart';
import 'package:path_provider/path_provider.dart';

class FileServerRepository implements IFileServerRepository {
  @override
  Future<String> downloadFile(String fileName) async {
    List<int> result;
    var header = Map<String, dynamic>();

    header['authorization'] = TextAddin.basicAuthenticationHeader(FS_USERNAME, FS_PASSWORD);

    try {
      Response response = await Dio().get(
        DATA_FILE_SERVER + fileName,
        //onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
          headers: header,
          responseType: ResponseType.bytes,
          followRedirects: false,
        ),
      );

      result = response.data;
    } catch (e) {
      DownloadFileException(e);
    }

    return _loadFile(Uint8List.fromList(result));
  }

  Future<String> _loadFile(Uint8List data) async {
    writeCounter(data);
    //var x = await existsFile();

    return (await _localFile).path;
    //PdfViewerPlugin.getPdfViewer((await _localFile).path, 80.0, width, height);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return new File('$path/temp.pdf');
  }

  Future<File> writeCounter(Uint8List stream) async {
    final file = await _localFile;
  
    // Write the file
    return file.writeAsBytes(stream);
  }

  Future<bool> existsFile() async {
    final file = await _localFile;
    return file.exists();
  }
}

abstract class IFileServerRepository {
  Future<String> downloadFile(String fileName);
}

class DownloadFileException implements Exception {
  final _message;

  DownloadFileException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception : $_message";
  }
}