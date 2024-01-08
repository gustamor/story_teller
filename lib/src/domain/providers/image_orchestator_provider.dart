import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/src/domain/services/image_service.dart';
import 'package:story_teller/src/domain/notifiers/image_controller_notifier.dart';
import 'package:story_teller/src/domain/image_process_state.dart';

/// Provides a state notifier for the image processing flow.
///
/// This provider initializes and manages an instance of [ImageProcessControllerNotifier],
/// which handles the orchestration of image processing tasks. The state of the image
/// processing is maintained in [ImageProcessState], allowing for reactive updates to
/// the UI or other dependent components as the state changes.
///
/// Within the `ImageProcessControllerNotifier`, an instance of [ImagesService] is created
/// and passed, enabling the controller to perform image-related operations. The `ref` argument
/// is used to interact with other providers or services within the Riverpod framework, ensuring
/// a cohesive and integrated state management approach.
final imageProcessOrchestratorProvider =
    StateNotifierProvider<ImageProcessControllerNotifier, ImageProcessState>(
        (ref) {
  final ImagesService imgService = ImagesService();
  return ImageProcessControllerNotifier(ref, imgService);
});
