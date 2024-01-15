// ignore_for_file: unused_import

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openai_dart/openai_dart.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/actions/tale/update_imageurl.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/actions/tale/upload_tale.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/actions/user/add_firestore_user.dart';

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
        uploadTaleProvider(
          taleData!,
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
           await  Future.delayed(const Duration(seconds: 2));
                ref.read(updateStoryWithImageUrl([taleData.id, imageUrl!])); //FB
           await  Future.delayed(const Duration(seconds: 2));

     

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
