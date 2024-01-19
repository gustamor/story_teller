import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

/// Abstract class defining the interface for Firebase Storage services.
///
/// Specifies methods for uploading images and saving files to Firebase Storage.
abstract class AbstractFireStorageService {
  /// Uploads an image file to Firebase Storage.
  ///
  /// Parameters:
  ///   [image]: The image file to be uploaded.
  ///   [reference]: The storage reference where the image will be stored.
  Future<void> uploadImage(File image, Reference reference);

  /// Saves a file to Firebase Storage based on the provided storage reference.
  ///
  /// Parameters:
  ///   [ref]: The storage reference where the file will be saved.
  Future<void> saveFile(Reference ref);
}