import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/data/api/model/tale_data.dart';
import 'package:story_teller/data/services/logger_impl.dart';
import 'package:story_teller/di/openai_providers.dart';
import 'package:story_teller/domain/chat_process_state.dart';
import 'package:story_teller/domain/services/abstract_tell_logger.dart';

class ChatProcessControllerNotifier extends StateNotifier<ChatProcessState> {
  final Ref ref;

  ChatProcessControllerNotifier(this.ref)
      : super(
          ChatProcessState(
            step: ChatProcessStep.generatingStory,
          ),
        );
  final TellLogger log = LogImpl();

  Future<TaleData> processAndStoreSimpleStory(prompt) async {
    final chatService = ref.watch(chatServiceProvider);
    try {
      state = ChatProcessState(
        step: ChatProcessStep.generatingStory,
      );
      if (kDebugMode) {
        log.d("Image Process State: ${state.step}");
      }

      TaleData taleData = await chatService.generateTale(prompt: prompt);

      state = ChatProcessState(
        step: ChatProcessStep.completed,
      );
      if (kDebugMode) {
        log.d("Image Process State: ${state.step}");
      }
      return taleData;

    } catch (e) {
      state = ChatProcessState(
        step: ChatProcessStep.error,
        errorMessage: e.toString(),
      );
      throw Exception("error in chat provider: tale data not generated");
    }
  }
}
