// ignore_for_file: unused_import

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:story_teller/domain/abstract/abstract_image_downloader_sevice.dart';


/// Service for downloading images.
///
/// Implements [AbstractImageDownloaderService] to provide functionality for downloading
/// images from a given URL and saving them to a specified path on the device.
class ImageDownloader implements AbstractImageDownloaderService {
  /// Dio package instance for making HTTP requests.
  @override
  final dio = Dio();

  /// Flag indicating whether the download was completed successfully.
  @override
  bool completed = false;

  /// Downloads an image from the given [url] and saves it to the [savePath].
  ///
  /// Sets [completed] to `true` if the download is successful, otherwise `false`.
  /// Returns `true` if the download and saving process is successful, otherwise `false`.
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
