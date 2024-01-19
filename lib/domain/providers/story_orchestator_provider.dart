

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/domain/abstract/abstract_process_state.dart';
import 'package:story_teller/domain/notifiers/story_controller_notifier.dart';

final storyProcessOrchestratorProvider =
    StateNotifierProvider<StoryProcessControllerNotifier, ProcessState>(
        (ref) {
  return StoryProcessControllerNotifier(ref);
});
