import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

abstract class AbstractFireStorageService {
  Future<void> uploadImage(File image, Reference reference);
  Future<void> saveFile(Reference ref);
}
