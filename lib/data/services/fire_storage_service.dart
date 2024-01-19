import 'dart:io';

import 'package:file_saver/file_saver.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:story_teller/domain/abstract/abstract_firestorage_service.dart';

class FireStorageService implements AbstractFireStorageService {
  @override
  Future<void> uploadImage(File image, Reference reference) async {
    try {
      await reference.putFile(image);
    } on FirebaseException catch (e) {
      throw ("Error $e");
    }
  }

  @override
  Future<void> saveFile(Reference ref) async {
 //   final isRef = ref;
    final name = ref.name;
    final appDocDir = await getApplicationDocumentsDirectory();
    final filePath = appDocDir.absolute;
    final fileName = "${filePath.path}/$name";
    final file = File(fileName);
    await FileSaver.instance.saveFile(name: name, file: file, filePath: filePath.path, ext:"png");
    
  }
   // isRef.writeToFile(file);
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

