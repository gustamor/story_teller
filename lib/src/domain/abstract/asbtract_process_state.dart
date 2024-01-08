
abstract class ProcessState<T>{
  T get step;
  String? get errorMessage;

  bool get isCompleted;
  bool get hasError;
}