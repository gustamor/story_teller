import 'package:story_teller/domain/abstract/abstract_process_state.dart';

enum StoryProcessStep {
  starting,
  generatingStory,
  generatingImage,
  savingImage,
  storyCompleted,
  imageCompleted,
  error,
}

class StoryProcessState implements ProcessState<StoryProcessStep> {
  @override
  final StoryProcessStep step;
  @override
  final String? errorMessage;

  StoryProcessState({required this.step, this.errorMessage});

  @override
  bool get isCompleted => step == StoryProcessStep.imageCompleted;
  @override
  bool get hasError => errorMessage != null;
}