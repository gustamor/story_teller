// ignore_for_file: unused_import

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openai_dart/openai_dart.dart';
import 'package:story_teller/data/network/api/firestore/tale/update_imageurl.dart';
import 'package:story_teller/data/network/api/firestore/tale/upload_tale.dart';
import 'package:story_teller/data/network/api/firestore/user/add_firestore_user.dart';

import 'package:story_teller/data/services/logger_impl.dart';
import 'package:story_teller/domain/abstract/abstract_process_state.dart';
import 'package:story_teller/domain/chat_process_state.dart';
import 'package:story_teller/domain/image_process_state.dart';
import 'package:story_teller/domain/providers/chat_orchestator_provider.dart';
import 'package:story_teller/domain/providers/image_orchestator_provider.dart';
import 'package:story_teller/domain/abstract/services/abstract_tell_logger.dart';
import 'package:story_teller/domain/story_process_state.dart';
import 'package:story_teller/ui/core/providers/current_tale_id_provider.dart';

/// Manages the process of generating and storing a story and its associated image.
///
/// Orchestrates the steps of generating a story text, uploading it, and processing a related image.
/// Maintains the current state of the story processing operation, providing detailed progress updates.
class StoryProcessControllerNotifier extends StateNotifier<ProcessState> {
  final Ref ref;

  /// Creates an instance of [StoryProcessControllerNotifier].
  ///
  /// Initializes the story process state to [StoryProcessStep.starting].
  StoryProcessControllerNotifier(this.ref)
      : super(
          StoryProcessState(
            step: StoryProcessStep.starting,
          ),
        );


  /// Generates a simple story based on the given [prompt] and processes its image.
  ///
  /// Sequentially progresses through generating the story, uploading the story data,
  /// generating the image, and updating the story with the image URL.
  /// Updates the state at each step and throws an exception if any step fails.
  Future<void> generateASimpleStory(String prompt) async {
    try {
      // Start the story generation process.
      state = StoryProcessState(step: StoryProcessStep.starting);
      final chatOrchestrator = ref.watch(chatProcessOrchestratorProvider.notifier);
      final imageOrchestrator = ref.watch(imageProcessOrchestratorProvider.notifier);

      // Generate the story based on the prompt.
      state = StoryProcessState(step: StoryProcessStep.generatingStory);
      final taleData = await chatOrchestrator.processAndStoreSimpleStory(prompt);

      // Upload the generated tale.
      ref.read(uploadTaleProvider(taleData!));
      ref.read(taleToShowProvider.notifier).update((state) => state = taleData.id);

      // Handle story generation completion or error.
      if (chatOrchestrator.state.step == ChatProcessStep.completed) {
        state = StoryProcessState(step: StoryProcessStep.storyCompleted);
      } else if (chatOrchestrator.state.step == ChatProcessStep.error) {
        state = StoryProcessState(step: StoryProcessStep.error);
      } else {
        state = StoryProcessState(step: StoryProcessStep.starting);
      }

      // Start the image generation process.
      state = StoryProcessState(step: StoryProcessStep.generatingImage);
      String? imageUrl = await imageOrchestrator.processAndStoreImage(taleData.prompt);

      // Handle image processing states.
      if (imageOrchestrator.state.step == ImageProcessStep.uploadingToStorage) {
        state = StoryProcessState(step: StoryProcessStep.savingImage);
      } else if (imageOrchestrator.state.step == ImageProcessStep.completed) {
        await Future.delayed(const Duration(seconds: 2));
        ref.read(updateStoryWithImageUrl([taleData.id, imageUrl!])); // Update Firestore
        await Future.delayed(const Duration(seconds: 2));

        state = StoryProcessState(step: StoryProcessStep.imageCompleted);
      } else if (imageOrchestrator.state.step == ImageProcessStep.error) {
        state = StoryProcessState(step: StoryProcessStep.error);
      }
    } catch (e) {
      // Set the state to error and capture the error message.
      state = StoryProcessState(step: StoryProcessStep.error);
      throw Exception(e);
    }
  }
}
