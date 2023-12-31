import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class StorageService {
  StorageService();

  Future<void> uploadImage(File image, Reference reference) async {
    try {
      await reference.putFile(image);
    } on FirebaseException catch (e) {
      throw ("Error $e");
    }
  }

  Future<void> getDownloadUrl(Reference ref) async {
    final islandRef = ref;
    final name = ref.name;
    final appDocDir = await getExternalStorageDirectory();
    final filePath = appDocDir!.absolute;
    final fileName = "${filePath.path}/$name";
    final file = File(fileName);

    final downloadTask = islandRef.writeToFile(file);
    downloadTask.snapshotEvents.listen((taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          // TODO: Handle this case.
          break;
        case TaskState.paused:
          // TODO: Handle this case.
          break;
        case TaskState.success:
          // TODO: Handle this case.
          break;
        case TaskState.canceled:
          // TODO: Handle this case.
          break;
        case TaskState.error:
          // TODO: Handle this case.
          break;
      }
    });
  }
}
