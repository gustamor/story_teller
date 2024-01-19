// ignore_for_file: unused_import

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/domain/services/image_service.dart';
import 'package:story_teller/data/services/logger_impl.dart';
import 'package:story_teller/domain/image_process_state.dart';
import 'package:story_teller/domain/services/abstract_tell_logger.dart';

/// Manages the state of image processing tasks.
///
/// Orchestrates the steps of generating an image, downloading it, uploading to storage,
/// and saving the link to Firestore. It maintains the current state of the image processing
/// operation, providing detailed progress updates.
class ImageProcessControllerNotifier extends StateNotifier<ImageProcessState> {
  final Ref ref;
  final ImagesService _imgService;

  /// Creates an instance of [ImageProcessControllerNotifier].
  ///
  /// Initializes the image process state to [ImageProcessStep.generatingImage].
  ImageProcessControllerNotifier(this.ref, this._imgService)
      : super(
          ImageProcessState(
            step: ImageProcessStep.generatingImage,
          ),
        );

  final TellLogger log = LogImpl();

  /// Processes an image based on the given [dallePrompt] and stores it.
  ///
  /// Sequentially progresses through generating the image, downloading it locally,
  /// uploading it to remote storage, and saving the download link to Firestore.
  /// Updates the state at each step and logs the current state if in debug mode.
  ///
  /// Returns the download link of the stored image or throws an exception if any step fails.
  Future<String?> processAndStoreImage(String dallePrompt) async {
    try {
      // Start the image generation process.
      state = ImageProcessState(step: ImageProcessStep.generatingImage);
      logState("Image Process State");

      // Generate the image and get the link.
      String? link = await _imgService.generateImage(ref, dallePrompt);
      if (link == null) throw Exception("Image generation failed");

      // Start downloading the image to local cache.
      state = ImageProcessState(step: ImageProcessStep.downloadingImageToLocalCache);
      logState("Image Process State");

      // Download the image from the generated link.
      String? fileName = await _imgService.downloadImageFromDalle(link);
      if (fileName == null) throw Exception("Image download failed");

      // Start uploading the image to remote storage.
      state = ImageProcessState(step: ImageProcessStep.uploadingToStorage);
      logState("Image Process State");

      // Upload the locally downloaded image to remote storage and get the download link.
      String? downloadLink = await _imgService.remoteStoreImage(ref, fileName);
      if (downloadLink == null) throw Exception("Image upload failed");

      // Start saving the download link to Firestore.
      state = ImageProcessState(step: ImageProcessStep.savingLinkToFirestore);
      logState("Image Process State");

      // Optionally: save the download link to Firestore (code commented out).

      // Mark the process as completed.
      state = ImageProcessState(step: ImageProcessStep.completed);
      logState("Image Process State");

      return downloadLink.toString();
    } catch (e) {
      // Set the state to error and capture the error message.
      state = ImageProcessState(step: ImageProcessStep.error, errorMessage: e.toString());
      // Optionally: log the error or handle it as needed.
      throw Exception(e);
    }
  }

  /// Logs the current state if in debug mode.
  ///
  /// Outputs the [message] and the current state's step to the logger.
  void logState(String message) {
    if (kDebugMode) {
      log.d("$message: ${state.step}");
    }
  }
}
