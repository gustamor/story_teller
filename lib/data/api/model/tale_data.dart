import 'package:story_teller/domain/abstract_%20taleData.dart';


class TaleData implements AbstractTaleData {
  @override
  final String storyId;
  @override
  final String title;
  @override
  final String text;
  @override
  final String? prompt;

  TaleData({required this.storyId, required this.title, required this.text, this.prompt});

  @override
  factory TaleData.fromMap(Map<String, dynamic> map) {
    if (!map.containsKey('storyId') || !map.containsKey('title') || !map.containsKey('text')) {
      throw FormatException("Missing required key(s) in map.");
    }
    return TaleData(
      storyId: map['storyId'] as String,
      title: map['title'] as String,
      text: map['text'] as String,
      prompt: map['prompt'] as String?,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'storyId': storyId,
      'title': title,
      'text': text,
      if (prompt != null) 'prompt': prompt,
    };
  }

  @override
  String toString() {
    return 'TaleData(storyId: $storyId, title: $title, text: $text, prompt: $prompt)';
  }
}
