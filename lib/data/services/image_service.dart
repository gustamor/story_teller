// ignore_for_file: unused_import, avoid_print

import 'dart:io';

import 'package:file_saver/file_saver.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openai_dart/openai_dart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:story_teller/core/params.dart';
import 'package:story_teller/core/permissions.dart';
import 'package:story_teller/data/di/dalle_response_provider.dart';
import 'package:story_teller/data/services/image_downloader_impl.dart';
import 'package:story_teller/data/network/api/openai/dalle_image_request.dart';
import 'package:story_teller/data/services/fire_storage_service.dart';
import 'package:story_teller/data/services/repositories/random_chars_repository.dart';
import 'package:story_teller/data/di/firebase_providers.dart';
import 'package:story_teller/data/di/openai_provider.dart';
import 'package:story_teller/data/network/api/firestore/tale/get_a_tale.dart';
import 'package:story_teller/domain/providers/auth_providers.dart';

class ImagesService {
  final _image = ImageDownloader();
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<String?> generateImage(Ref ref, String dallePrompt) async {
    final DalleImageRequest dalle = ref.watch(dalleProvider);
    try {
      String? link = await dalle.generateImageLink(
          prompt: dallePrompt,
          model: Params.dalleModel.model,
          quality: Params.dalleModel.quality,
          size: Params.dalleModel.size,
          style: Params.dalleModel.style);
      return link;
    } catch (e) {
      throw Exception("image_servie $e");
    }
  }

  Future<String?> downloadImageFromDalle(String link) async {
    try {
      final random = RandomRepository();
      final name = random.generateRandomString(16);
      final path = await _localPath;
      String localFileName = "$path/$name.png";
      await _image.downloadImageFromUrl(link, localFileName);
      return name;
    } catch (e) {
      throw Exception("");
    }
  }

  Future<String?> remoteStoreImage(Ref ref, String fileName) async {
    final storage = FireStorageService();
    final storageRef = ref.watch(firebaseStorageProvider).ref();
    final currentUser =
        await ref.watch(authenticationProvider).getCurrentUser(); //Si el User.uid no tendrá accesos a storage

    try {
      final reference =
          storageRef.child("image/${currentUser!.uid}/$fileName.png");
      final path = await _localPath;
      final file = "$path/$fileName.png";
      await storage.uploadImage(File(file), reference);
      saveFile(reference);
      final downloadLink = await reference.getDownloadURL();

      return downloadLink;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> saveFile(Reference ref) async {
    try {
      final name = ref.name;

      final appDocDir = await getExternalStorageDirectory();
      final filePath = '${appDocDir!.path}/$name';
      final file = File(filePath);

      await ref.writeToFile(file);

      print("Archivo guardado en: $filePath");
    } catch (e) {
      print("Error al guardar el archivo: $e");
    }
  }
}
