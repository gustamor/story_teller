// ignore_for_file: unused_import

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openai_dart/openai_dart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:story_teller/data/repositories/image_downloader_repository.dart';
import 'package:story_teller/data/repositories/openai/dalle_image.dart';
import 'package:story_teller/data/services/fire_storage.dart';
import 'package:story_teller/data/services/random_names.dart';
import 'package:story_teller/di/firebase_providers.dart';
import 'package:story_teller/domain/providers/auth_providers.dart';

class ImagesService {
  final _repo = ImageDownloaderRepository();
  Future<String> get _localPath async {
    final directory = await getApplicationCacheDirectory();
    return directory.path;
  }

  Future<String?> generateImage(DalleImage dalle, String dallePrompt) async {
    try {
      String? link = await dalle.generateImageLink(
        prompt: dallePrompt,
        model: ImageModels.dallE2,
      );
      return link;
    } catch (e) {
      throw Exception("");
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
    final currentUser = await ref.watch(authenticationProvider).getCurrentUser();
    final userEmail = currentUser!.email;
      try {
      final reference = storageRef.child("image/$userEmail/$fileName.png");
      final path = await _localPath;
      final file = "$path/$fileName.png";
      await storage.uploadImage(File(file), reference);
      final downloadLink = await reference.getDownloadURL();
      return downloadLink;
    } catch (e) {
      throw Exception("Error when store image");
    }
  }

  Future<String?> savingImageUrlToFirestore(String storageLink) async {
    try {
      // await ref.saveImageLink(storageLink);
    } catch (e) {}
    return null;
  }
}
