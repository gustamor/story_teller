
/// Abstract class representing the state of a process.
///
/// Provides properties for tracking the current step, error messages, and completion status.
abstract class ProcessState<T> {
  /// The current step or stage of the process.
  T get step;

  /// An error message if the process encounters an error.
  String? get errorMessage;

  /// A boolean indicating whether the process is completed.
  bool get isCompleted;

  /// A boolean indicating whether the process has encountered an error.
  bool get hasError;
}