// ignore_for_file: unused_import

import 'package:story_teller/constants.dart';
import 'package:story_teller/data/bbdd/firestore/models/simple_story.dart';
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
  /// The map must contain the keys 'title', 'story', and optionally 'prompt'.
  /// Throws a [FormatException] if 'title' or 'story' keys are missing.
  @override
  factory TaleData.fromMap(Map<String, dynamic> map) {
    if (!map.containsKey('title') || !map.containsKey('story')) {
      throw const FormatException("Missing required key(s) 'title' or 'story'.");
    }
    return TaleData(
      id: kUuid.v4(),
      title: map['title'] as String,
      story: (map['story'] as String).replaceAll('"', '\''),
      prompt: map['prompt'] as String?,
    );
  }

  /// Converts the [TaleData] instance into a map of key/value pairs.
  ///
  /// Includes 'id', 'title', 'story', and 'prompt' (if not null).
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

  /// Converts the [TaleData] instance to a [Story] object.
  ///
  /// Returns a new [Story] object with properties copied from [TaleData] and
  /// additional properties set, such as the current date and user ID.
  @override
  Story toStory(String userId) {
    Story story = Story.fromMap(toMap());
    story.date = DateTime.now();
    story.user = userId;
    return story;
  }
}
