import 'package:story_teller/constants.dart';
import 'package:story_teller/domain/abstract_%20taleData.dart';
import 'package:uuid/uuid.dart';

class TaleData implements AbstractTaleData {
  @override
  final String id;
  @override
  final String title;
  @override
  final String story;
  @override
  final String? prompt;

  TaleData(
      {required this.id,
      required this.title,
      required this.story,
      this.prompt});

  @override
  factory TaleData.fromMap(Map<String, dynamic> map) {
    if (
        !map.containsKey('title') ||
        !map.containsKey('prompt') ||
        !map.containsKey('story')) {
      throw const FormatException("Missing required key(s) in map.");
    }
    return TaleData(
      id: kUuid.v4(),
      title: map['title'] as String,
      story: map['story'] as String,
      prompt: map['prompt'] as String?,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'story': story,
      if (prompt != null) 'prompt': prompt,
    };
  }

  @override
  String toString() {
    return 'TaleData(id: $id, title: $title, story: $story, prompt: $prompt)';
  }
}
