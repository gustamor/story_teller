import 'package:dio/dio.dart';

abstract class AbstractImageDownloaderService {
  final dio = Dio();
  bool completed = false;

  Future<bool> downloadImageFromUrl(String url, String savePath);
}
