

abstract class AbstractTaleData {
  String get storyId;
  String get title;
  String get text;
  String? get prompt;

  factory AbstractTaleData.fromMap(Map<String, dynamic> map) {
    throw UnimplementedError('fromMap() has not been implemented.');
  }

  Map<String, dynamic> toMap();

  @override
  String toString();
}