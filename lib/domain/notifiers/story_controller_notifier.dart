// ignore_for_file: unused_import

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openai_dart/openai_dart.dart';
import 'package:story_teller/data/bbdd/isar/actions/add_tale_provider.dart';
import 'package:story_teller/data/bbdd/isar/actions/update_tale_with_image_provider.dart';
import 'package:story_teller/data/services/logger_impl.dart';
import 'package:story_teller/domain/chat_process_state.dart';
import 'package:story_teller/domain/image_process_state.dart';
import 'package:story_teller/domain/providers/chat_orchestator_provider.dart';
import 'package:story_teller/domain/providers/image_orchestator_provider.dart';
import 'package:story_teller/domain/services/abstract_tell_logger.dart';
import 'package:story_teller/domain/story_process_state.dart';

class StoryProcessControllerNotifier extends StateNotifier<ProcessState> {
  final Ref ref;

  StoryProcessControllerNotifier(this.ref)
      : super(
          StoryProcessState(
            step: StoryProcessStep.starting,
          ),
        );
  final TellLogger log = LogImpl();

  Future<void> generateASimpleStory() async {
    try {
      final chatOrchestator =
          ref.watch(chatProcessOrchestratorProvider.notifier);
      final imageOrchestator =
          ref.watch(imageProcessOrchestratorProvider.notifier);

      state = StoryProcessState(
        step: StoryProcessStep.generatingStory,
      );
      final taleData = await chatOrchestator.processAndStoreSimpleStory();
      ref.read(addTaleProvider(taleData));

      if (chatOrchestator.state.step == ChatProcessStep.completed) {
        state = StoryProcessState(
          step: StoryProcessStep.storyCompleted,
        );
      } else if (chatOrchestator.state.step == ChatProcessStep.error) {
        state = StoryProcessState(
          step: StoryProcessStep.error,
        );
      } else {
        state = StoryProcessState(
          step: StoryProcessStep.starting,
        );
      }

      state = StoryProcessState(
        step: StoryProcessStep.generatingImage,
      );
      String? imageUrl =
          await imageOrchestator.processAndStoreImage(taleData.prompt!);

      if (imageOrchestator.state.step == ImageProcessStep.uploadingToStorage) {
        state = StoryProcessState(
          step: StoryProcessStep.savingImage,
        );
      } else if (imageOrchestator.state.step == ImageProcessStep.completed) {
        ref.read(upateTaleWithImageProvider([taleData.id, imageUrl ?? ""]));
        state = StoryProcessState(
          step: StoryProcessStep.imageCompleted,
        );
      } else if (imageOrchestator.state.step == ImageProcessStep.error) {
        state = StoryProcessState(
          step: StoryProcessStep.error,
        );
      }
    } catch (e) {
      state = StoryProcessState(
        step: StoryProcessStep.error,
      );
      throw Exception(
        e,
      );
    }
  }
}
