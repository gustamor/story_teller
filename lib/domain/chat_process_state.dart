enum ChatProcessStep{
  generatingStory,
  completed,
  error,
}

class ChatProcessState implements ProcessState<ChatProcessStep>{
  @override
  final ChatProcessStep step;
  @override
  final String? errorMessage;

  ChatProcessState({required this.step, this.errorMessage});

  @override
  bool get isCompleted => step == ChatProcessStep.completed;
  @override
  bool get hasError => errorMessage != null;
}

abstract class ProcessState<T>{
  T get step;
  String? get errorMessage;

  bool get isCompleted;
  bool get hasError;
}
