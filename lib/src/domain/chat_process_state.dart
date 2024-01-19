import 'package:story_teller/domain/abstract/abstract_process_state.dart';

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

