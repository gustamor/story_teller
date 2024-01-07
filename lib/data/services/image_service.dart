// ignore_for_file: unused_import

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openai_dart/openai_dart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:story_teller/data/services/dalle_image.dart';
import 'package:story_teller/data/services/repositories/image_downloader_repository.dart';
import 'package:story_teller/data/api/openai/dalle_image.dart';
import 'package:story_teller/data/services/fire_storage.dart';
import 'package:story_teller/data/services/random_names.dart';
import 'package:story_teller/data/di/firebase_providers.dart';
import 'package:story_teller/data/di/openai_provider.dart';
import 'package:story_teller/domain/providers/auth_providers.dart';

class ImagesService {
  final _repo = ImageDownloaderRepository();
  Future<String> get _localPath async {
    final directory = await getApplicationCacheDirectory();
    return directory.path;
  }

  Future<String?> generateImage(Ref ref, String dallePrompt) async {
    final DalleImage dalle = ref.watch(dalleProvider);
    try {
      String? link = await dalle.generateImageLink(
        prompt: dallePrompt,
        model: ImageModels.dallE2,
      );
      return link;
    } catch (e) {
      throw Exception("image_servie $e");
    }
  }

  Future<String?> downloadImage(String link) async {
    try {
      final random = RandomRepository();
      final name = random.generateRandomString(16);
      final path = await _localPath;
      String localFileName = "$path/$name.png";
      await _repo.downloadImageFromUrl(link, localFileName);
      return name;
    } catch (e) {
      throw Exception("");
    }
  }

  Future<String?> remoteStoreImage(Ref ref, String fileName) async {
    final storage = StorageService();
    final storageRef = ref.watch(firebaseStorageProvider).ref();
    final currentUser = ref.watch(authenticationProvider).getDisplayName();
      try {
      final reference = storageRef.child("image/$currentUser/$fileName.png");
      final path = await _localPath;
      final file = "$path/$fileName.png";
      await storage.uploadImage(File(file), reference);
      final downloadLink = await reference.getDownloadURL();
      return downloadLink;
    } catch (e) {
      throw Exception(e);
    }
  }

}
