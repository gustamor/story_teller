// ignore_for_file: unused_import

import 'package:story_teller/src/core/constants.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/models/simple_story.dart';
import 'package:story_teller/src/domain/abstract/abstract_tale_data.dart';
import 'package:uuid/uuid.dart';

/// Represents the data structure of a tale.
///
/// This class provides a concrete implementation of the [AbstractTaleData] interface, encapsulating
/// the essential elements of a tale such as its ID, title, story, and prompt.
class TaleData implements AbstractTaleData {
  @override
  final String id;

  @override
  final String title;

  @override
  final String story;

  @override
  final String prompt;

  /// Constructs a [TaleData] object with the provided [id], [title], [story], and [prompt].
  ///
  /// The [id] is typically generated to uniquely identify the tale. Both [title] and [story] are
  /// required fields, along with the [prompt] which provides context or inspiration for the tale.
  TaleData(
      {required this.id,
      required this.title,
      required this.story,
      required this.prompt});

  /// Factory constructor to create a [TaleData] instance from a map of key/value pairs.
  ///
  /// This method expects the map to contain 'title', 'story', and 'prompt' keys. If any of these keys
  /// are missing, a [FormatException] is thrown. The ID is generated using a UUID.
  @override
  factory TaleData.fromMap(Map<String, dynamic> map) {
    if (!map.containsKey('title') ||
        !map.containsKey('story') ||
        !map.containsKey('prompt')) {
      throw const FormatException(
          "Missing required key(s) 'title', 'story', or 'prompt'.");
    }
    return TaleData(
      id: const Uuid().v4(),
      title: map['title'] as String,
      story: (map['story'] as String).replaceAll('"', '\''),
      prompt: map['prompt'] as String,
    );
  }

  /// Converts the current [TaleData] instance to a map.
  ///
  /// This conversion is useful for serialization or storage purposes, including all relevant tale fields.
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'story': story,
      'prompt': prompt,
    };
  }

  /// Returns a string representation of the [TaleData] instance.
  ///
  /// Useful for debugging and logging, this method provides a human-readable format of the tale's data.
  @override
  String toString() {
    return 'TaleData(id: $id, title: $title, story: $story, prompt: $prompt)';
  }

  /// Converts the [TaleData] instance to a [Story] object.
  ///
  /// This method creates a [Story] instance using the tale's data. It sets the current date and the
  /// specified [userId] to the new [Story] object, linking it to a user context.
  @override
  Story toStory(String userId) {
    final storyInstance = Story.fromMap(toMap());
    storyInstance.date = DateTime.now();
    storyInstance.user = userId;
    return storyInstance;
  }
}
