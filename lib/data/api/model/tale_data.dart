// ignore_for_file: unused_import

import 'package:story_teller/constants.dart';
import 'package:story_teller/domain/abstract_%20taleData.dart';
import 'package:uuid/uuid.dart';
/// Represents the data for a tale.
/// 
/// This class implements the [AbstractTaleData] interface and provides
/// details such as a unique identifier, title, story, and an optional prompt
/// associated with a tale.
class TaleData implements AbstractTaleData {
  @override
  final String id;

  @override
  final String title;

  @override
  final String story;

  @override
  final String? prompt;

  /// Creates a new instance of [TaleData].
  /// 
  /// Requires [id], [title], and [story] to be provided. [prompt] is optional.
  TaleData(
      {required this.id,
      required this.title,
      required this.story,
      this.prompt});

  /// Creates a new [TaleData] instance from a map of key/value pairs.
  /// 
  /// The map must contain the keys 'title', 'prompt', and 'story'.
  /// Throws a [FormatException] if any of these keys are missing.
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
      story: map['story'].replaceAll('"', '\'') as String,
      prompt: map['prompt'] as String?,
    );
  }

  /// Converts the [TaleData] instance into a map of key/value pairs.
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'story': story,
      if (prompt != null) 'prompt': prompt,
    };
  }

  /// Returns a string representation of the [TaleData] instance.
  @override
  String toString() {
    return 'TaleData(id: $id, title: $title, story: $story, prompt: $prompt)';
  }
}
