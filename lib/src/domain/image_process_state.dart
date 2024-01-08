import 'package:story_teller/src/domain/abstract/asbtract_process_state.dart';

enum ImageProcessStep {
  generatingImage,
  downloadingImageToLocalCache,
  uploadingToStorage,
  savingLinkToFirestore,
  completed,
  error,
}

class ImageProcessState implements ProcessState<ImageProcessStep> {
  @override
  final ImageProcessStep step;
  @override
  final String? errorMessage;

  ImageProcessState({required this.step, this.errorMessage});

  @override
  bool get isCompleted => step == ImageProcessStep.completed;
  @override
  bool get hasError => errorMessage != null;
}