import 'package:story_teller/domain/abstract/abstract_process_state.dart';

/// Represents the steps in the chat processing workflow.
///
/// This enum is used to track the current state of the chat process.
enum ChatProcessStep {
  /// Indicates that the story is currently being generated.
  generatingStory,

  /// Indicates that the process has completed successfully.
  completed,

  /// Indicates that an error has occurred during the process.
  error,
}

/// Maintains the state of a chat process.
///
/// This class implements [ProcessState] for a chat process, tracking the current
/// [ChatProcessStep] and any associated error message.
class ChatProcessState implements ProcessState<ChatProcessStep> {
  /// The current step of the chat process.
  @override
  final ChatProcessStep step;

  /// An optional error message describing an error state, if any.
  ///
  /// If there is no error, this is `null`.
  @override
  final String? errorMessage;

  /// Creates a [ChatProcessState] with the given [step] and an optional [errorMessage].
  ///
  /// - [step]: The current step of the chat process.
  /// - [errorMessage]: An optional error message if the state represents an error.
  ChatProcessState({required this.step, this.errorMessage});

  /// Returns `true` if the chat process has completed successfully.
  @override
  bool get isCompleted => step == ChatProcessStep.completed;

  /// Returns `true` if there is an error in the chat process.
  ///
  /// It checks if [errorMessage] is not `null` to determine if there is an error.
  @override
  bool get hasError => errorMessage != null;
}
