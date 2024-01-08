// ignore_for_file: unused_import

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openai_dart/openai_dart.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/actions/add_user.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/actions/update_imageurl.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/actions/upload_tale.dart';
import 'package:story_teller/src/data/sources/bbdd/isar/actions/tale/add_tale_provider.dart';
import 'package:story_teller/src/data/sources/bbdd/isar/actions/tale/update_tale_with_image_provider.dart';
import 'package:story_teller/src/data/services/logger_impl.dart';
import 'package:story_teller/src/domain/abstract/asbtract_process_state.dart';
import 'package:story_teller/src/domain/chat_process_state.dart';
import 'package:story_teller/src/domain/image_process_state.dart';
import 'package:story_teller/src/domain/providers/chat_orchestator_provider.dart';
import 'package:story_teller/src/domain/providers/image_orchestator_provider.dart';
import 'package:story_teller/src/domain/services/abstract_tell_logger.dart';
import 'package:story_teller/src/domain/story_process_state.dart';
import 'package:story_teller/src/ui/core/providers/current_tale_id_provider.dart';

class StoryProcessControllerNotifier extends StateNotifier<ProcessState> {
  final Ref ref;

  StoryProcessControllerNotifier(this.ref)
      : super(
          StoryProcessState(
            step: StoryProcessStep.starting,
          ),
        );
  final TellLogger log = LogImpl();

  Future<void> generateASimpleStory(String prompt) async {
    try {
      state = StoryProcessState(
        step: StoryProcessStep.starting,
      );
      final chatOrchestator =
          ref.watch(chatProcessOrchestratorProvider.notifier);
      final imageOrchestator =
          ref.watch(imageProcessOrchestratorProvider.notifier);

      state = StoryProcessState(
        step: StoryProcessStep.generatingStory,
      );
      final taleData = await chatOrchestator.processAndStoreSimpleStory(prompt);
      ref.read(
        addTaleProvider(
          taleData!,
        ),
      );
      ref.read(
        uploadTaleProvider(
          taleData,
        ),
      );
      ref.read(taleToShowProvider.notifier).update((state) => state = taleData.id);

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
          await imageOrchestator.processAndStoreImage(taleData.prompt);

      if (imageOrchestator.state.step == ImageProcessStep.uploadingToStorage) {
        state = StoryProcessState(
          step: StoryProcessStep.savingImage,
        );
      } else if (imageOrchestator.state.step == ImageProcessStep.completed) {
            ref.read(upateTaleWithImageProvider([taleData.id, imageUrl!]));
             Future.delayed(const Duration(seconds: 1));
                ref.read(upateStoryWithImageUrl([taleData.id, imageUrl]));

     

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
