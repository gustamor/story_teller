import 'package:dio/dio.dart';


/// Abstract class defining the interface for image downloading services.
///
/// Specifies methods for downloading images from a URL.
abstract class AbstractImageDownloaderService {
  final dio = Dio();
  bool completed = false;

  /// Downloads an image from the specified URL and saves it to the given path.
  ///
  /// Parameters:
  ///   [url]: The URL of the image to be downloaded.
  ///   [savePath]: The local path where the image will be saved.
  ///
  /// Returns:
  ///   A boolean indicating whether the download was successful.
  Future<bool> downloadImageFromUrl(
    String url,
    String savePath,
  );
}