import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/domain/chat_process_state.dart';
import 'package:story_teller/domain/notifiers/chat_controller_notifier.dart';

final chatProcessOrchestratorProvider =
    StateNotifierProvider<ChatProcessControllerNotifier, ChatProcessState>(
        (ref) {
  return ChatProcessControllerNotifier(ref);
});
