enum ImageProcessStep {
  generatingImage,
  downloadingImageToLocalCache,
  uploadingToStorage,
  savingLinkToFirestore,
  completed,
  error,
}

class ImageProcessState {
  final ImageProcessStep step;
  final String? errorMessage;

  ImageProcessState({required this.step, this.errorMessage});

  bool get isCompleted => step == ImageProcessStep.completed;
  bool get hasError => errorMessage != null;
}