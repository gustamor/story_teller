import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/data/services/image_service.dart';
import 'package:story_teller/domain/notifiers/image_controller_notifier.dart';
import 'package:story_teller/domain/image_process_state.dart';

final imageProcessOrchestratorProvider =
    StateNotifierProvider<ImageProcessControllerNotifier, ImageProcessState>(
        (ref) {
  final ImagesService imgService = ImagesService();
  return ImageProcessControllerNotifier(ref, imgService);
});
