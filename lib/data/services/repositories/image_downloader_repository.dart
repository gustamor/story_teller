// ignore_for_file: unused_import

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class ImageDownloaderRepository {
  final dio = Dio();
  bool completed = false;

  Future<bool> downloadImageFromUrl(String url, String savePath) async {
    completed = false;
    try {
      await dio.download(
        url,
        savePath,
      );
      completed = true;
    } catch (e) {
      completed = false;
    }
    return completed;
  }
}
