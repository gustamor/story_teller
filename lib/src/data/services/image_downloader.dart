// ignore_for_file: unused_import

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:story_teller/src/domain/abstract/abstract_image_downloader_sevice.dart';

class ImageDownloader implements AbstractImageDownloaderService {
  @override
  final dio = Dio();

  @override
  bool completed = false;

  @override
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
