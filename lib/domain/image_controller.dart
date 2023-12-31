import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/data/repositories/openai/dalle_image.dart';
import 'package:story_teller/data/services/image_service.dart';
import 'package:story_teller/data/services/logger_impl.dart';
import 'package:story_teller/domain/image_process.dart';
import 'package:story_teller/domain/services/abstract_tell_logger.dart';

class ImageProcessController extends StateNotifier<ImageProcessState> {
  final Ref ref;
  final ImagesService _imgService;
  late final DalleImage _dalle;

  ImageProcessController(this.ref, this._dalle, this._imgService)
      : super(
          ImageProcessState(
            step: ImageProcessStep.generatingImage,
          ),
        );

  final TellLogger log = LogImpl();

  Future<void> processAndStoreImage(String dallePrompt) async {
    
    try {
      state = ImageProcessState(
        step: ImageProcessStep.generatingImage,
      );
      if (kDebugMode) {
        log.d("Image Process State: ${state.step}");
      }
      String? link = await _imgService.generateImage(
        _dalle,
        dallePrompt,
      );
      if (link == null) throw Exception("No se pudo generar la imagen");
      state = ImageProcessState(
        step: ImageProcessStep.downloadingImageToLocalCache,
      );
      if (kDebugMode) {
        log.d("Image Process State: ${state.step}");
      }
      String? fileName = await _imgService.downloadImage(link);
      if (fileName == null)
        throw Exception(
          "Error al descargar la imagen",
        );

      state = ImageProcessState(step: ImageProcessStep.uploadingToStorage);
      if (kDebugMode) {
        log.d("Image Process State: ${state.step}");
      }

      String? downloadLink =
          await _imgService.remoteStoreImage(ref, fileName);
      if (downloadLink == null) {
        throw Exception("Error al almacenar la imagen remotamente");
      }
    
      state = ImageProcessState(step: ImageProcessStep.savingLinkToFirestore);
  
      if (kDebugMode) {
        log.d("Image Process State: ${state.step}");
      }

      //  await savingImageUrlToFirestore(downloadLink);

      state = ImageProcessState(step: ImageProcessStep.completed);
      if (kDebugMode) {
        log.d("Image Process State: ${state.step}");
      }
    } catch (e) {
      state = ImageProcessState(
          step: ImageProcessStep.error, errorMessage: e.toString());
    }
  }
}
