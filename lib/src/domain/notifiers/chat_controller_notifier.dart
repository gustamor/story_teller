import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:story_teller/src/data/sources/api/model/tale_data.dart';
import 'package:story_teller/src/data/services/logger_impl.dart';
import 'package:story_teller/src/data/di/taledata_provider.dart';
import 'package:story_teller/src/domain/chat_process_state.dart';
import 'package:story_teller/src/domain/services/abstract_tell_logger.dart';

class ChatProcessControllerNotifier extends StateNotifier<ChatProcessState> {
  final Ref ref;

  ChatProcessControllerNotifier(this.ref)
      : super(
          ChatProcessState(
            step: ChatProcessStep.generatingStory,
          ),
        );
  final TellLogger log = LogImpl();

  Future<TaleData?> processAndStoreSimpleStory(prompt) async {
    try {
      state = ChatProcessState(
        step: ChatProcessStep.generatingStory,
      );
      if (kDebugMode) {
        log.d("Image Process State: ${state.step}");
      }

      final taleData = ref.watch(taleDataProvider(prompt).future);

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
