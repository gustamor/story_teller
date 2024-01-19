import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/domain/chat_process_state.dart';
import 'package:story_teller/domain/notifiers/chat_controller_notifier.dart';

/// Provides a state notifier for the chat process.
///
/// This provider creates and manages an instance of [ChatProcessControllerNotifier], which
/// is responsible for orchestrating the chat process flow. It maintains and updates the state
/// of the chat process, encapsulated in [ChatProcessState].
///
/// The `StateNotifierProvider` ensures that any listeners are notified of state changes,
/// enabling reactive updates in the UI or other dependent components. The `ref` argument
/// is used within `ChatProcessControllerNotifier` to interact with other providers or
/// services as needed.
final chatProcessOrchestratorProvider =
    StateNotifierProvider<ChatProcessControllerNotifier, ChatProcessState>(
        (ref) {
  return ChatProcessControllerNotifier(ref);
});
