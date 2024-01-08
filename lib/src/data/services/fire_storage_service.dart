import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:story_teller/src/domain/abstract/abstract_firestorage_service.dart';

class FireStorageService implements AbstractFireStorageService {
  FireStorageService();
  @override
  Future<void> uploadImage(File image, Reference reference) async {
    try {
      await reference.putFile(image);
    } on FirebaseException catch (e) {
      throw ("Error $e");
    }
  }

  @override
  Future<void> getDownloadUrl(Reference ref) async {
    final isRef = ref;
    final name = ref.name;
    final appDocDir = await getExternalStorageDirectory();
    final filePath = appDocDir!.absolute;
    final fileName = "${filePath.path}/$name";
    final file = File(fileName);
    isRef.writeToFile(file);
//    final downloadTask = isRef.writeToFile(file);
    /* downloadTask.snapshotEvents.listen((taskSnapshot) {
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
    }); */
  }
}
