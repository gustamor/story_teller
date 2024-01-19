import 'package:story_teller/domain/abstract/abstract_process_state.dart';

/// Represents the steps in the image processing workflow.
///
/// This enum is used to track the current state of the image processing.
enum ImageProcessStep {
  /// Indicates that the image is currently being generated.
  generatingImage,
  
  /// Indicates that the generated image is being downloaded to local cache.
  downloadingImageToLocalCache,
  
  /// Indicates that the image is being uploaded to storage.
  uploadingToStorage,
  
  /// Indicates that the link to the image is being saved to Firestore.
  savingLinkToFirestore,
  
  /// Indicates that the process has completed successfully.
  completed,
  
  /// Indicates that an error has occurred during the process.
  error,
}

/// Maintains the state of an image processing task.
///
/// This class implements [ProcessState] for an image processing task, tracking
/// the current [ImageProcessStep] and any associated error message.
class ImageProcessState implements ProcessState<ImageProcessStep> {
  /// The current step of the image processing task.
  @override
  final ImageProcessStep step;

  /// An optional error message describing an error state, if any.
  ///
  /// If there is no error, this is `null`.
  @override
  final String? errorMessage;

  /// Creates an [ImageProcessState] with the given [step] and an optional [errorMessage].
  ///
  /// - [step]: The current step of the image processing task.
  /// - [errorMessage]: An optional error message if the state represents an error.
  ImageProcessState({required this.step, this.errorMessage});

  /// Returns `true` if the image processing task has completed successfully.
  @override
  bool get isCompleted => step == ImageProcessStep.completed;

  /// Returns `true` if there is an error in the image processing task.
  ///
  /// It checks if [errorMessage] is not `null` to determine if there is an error.
  @override
  bool get hasError => errorMessage != null;
}
