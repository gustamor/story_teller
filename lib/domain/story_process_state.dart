import 'package:story_teller/domain/abstract/abstract_process_state.dart';

/// Represents the steps in the story processing workflow.
///
/// This enum is used to track the current state of the story processing.
enum StoryProcessStep {
  /// Indicates the start of the story processing.
  starting,

  /// Indicates that the story is currently being generated.
  generatingStory,

  /// Indicates that an image for the story is currently being generated.
  generatingImage,

  /// Indicates that the generated image is being saved.
  savingImage,

  /// Indicates that the story processing has completed.
  storyCompleted,

  /// Indicates that the image processing related to the story has completed.
  imageCompleted,

  /// Indicates that an error has occurred during the process.
  error,
}

/// Maintains the state of a story processing task.
///
/// This class implements [ProcessState] for a story processing task, tracking
/// the current [StoryProcessStep] and any associated error message.
class StoryProcessState implements ProcessState<StoryProcessStep> {
  /// The current step of the story processing task.
  @override
  final StoryProcessStep step;

  /// An optional error message describing an error state, if any.
  ///
  /// If there is no error, this is `null`.
  @override
  final String? errorMessage;

  /// Creates a [StoryProcessState] with the given [step] and an optional [errorMessage].
  ///
  /// - [step]: The current step of the story processing task.
  /// - [errorMessage]: An optional error message if the state represents an error.
  StoryProcessState({required this.step, this.errorMessage});

  /// Returns `true` if the story processing task has completed successfully, specifically
  /// when the image related to the story has also been completed.
  @override
  bool get isCompleted => step == StoryProcessStep.imageCompleted;

  /// Returns `true` if there is an error in the story processing task.
  ///
  /// It checks if [errorMessage] is not `null` to determine if there is an error.
  @override
  bool get hasError => errorMessage != null;
}
