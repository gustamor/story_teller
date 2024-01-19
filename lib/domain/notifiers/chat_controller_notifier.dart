import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:story_teller/data/sources/api/model/tale_data.dart';
import 'package:story_teller/data/services/logger_impl.dart';
import 'package:story_teller/data/di/taledata_provider.dart';
import 'package:story_teller/domain/chat_process_state.dart';
import 'package:story_teller/domain/services/abstract_tell_logger.dart';

/// Manages the state of chat processes, particularly story generation.
///
/// Holds the state of the current chat process and provides a method to process
/// and store a simple story. It transitions through various [ChatProcessStep]s
/// indicating the progress of the story generation.
class ChatProcessControllerNotifier extends StateNotifier<ChatProcessState> {
  final Ref ref;

  /// Creates an instance of [ChatProcessControllerNotifier].
  ///
  /// Initializes the chat process state to [ChatProcessStep.generatingStory].
  ChatProcessControllerNotifier(this.ref)
      : super(
          ChatProcessState(
            step: ChatProcessStep.generatingStory,
          ),
        );

  final TellLogger log = LogImpl();

  /// Processes and stores a simple story based on the given [prompt].
  ///
  /// Starts by setting the state to [ChatProcessStep.generatingStory]. If in debug mode,
  /// logs the current state. Retrieves the tale data and updates the state to
  /// [ChatProcessStep.completed]. If an error occurs, sets the state to [ChatProcessStep.error]
  /// and logs the error message. Throws an exception if tale data generation fails.
  ///
  /// Returns the generated [TaleData] or `null` if the process fails.
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
      if (kDebugMode) {
        log.d("Error in Chat Process State: ${e.toString()}");
      }
      throw Exception("error in chat provider: tale data not generated");
    }
  }
}
