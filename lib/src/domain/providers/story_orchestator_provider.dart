

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/src/domain/abstract/asbtract_process_state.dart';
import 'package:story_teller/src/domain/notifiers/story_controller_notifier.dart';

final storyProcessOrchestratorProvider =
    StateNotifierProvider<StoryProcessControllerNotifier, ProcessState>(
        (ref) {
  return StoryProcessControllerNotifier(ref);
});
