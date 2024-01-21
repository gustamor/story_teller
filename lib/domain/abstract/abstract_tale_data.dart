import 'package:story_teller/data/network/api/firestore/model/simple_story.dart';

/// Abstract class defining the structure of tale data.
///
/// This class outlines the properties and methods that any tale data representation
/// must have. Implementations of this class are expected to provide concrete details
/// for each of these abstract members. The class includes essential tale-related
/// attributes like ID, title, story, and prompt.
abstract class AbstractTaleData {
  /// Unique identifier of the tale.
  String get id;

  /// Title of the tale.
  String get title;

  /// The story content of the tale.
  String get story;

  /// A prompt associated with the tale.
  String get prompt;

  /// Factory constructor to create an instance from a map.
  ///
  /// This method is expected to be implemented in concrete subclasses to allow
  /// instantiation of tale data from a map structure. Throws [UnimplementedError]
  /// if called on the abstract class directly.
  factory AbstractTaleData.fromMap(Map<String, dynamic> map) {
    throw UnimplementedError('fromMap() has not been implemented.');
  }

  /// Converts the tale data to a map.
  ///
  /// This method should be implemented to provide a map representation of the tale data,
  /// typically for serialization or storage purposes.
  Map<String, dynamic> toMap();

  @override
  /// Returns a string representation of the tale data.
  ///
  /// This method should be overridden to provide a meaningful string description of the tale data.
  String toString();

  /// Converts the tale data to a [Story] object, associating it with a given user ID.
  ///
  /// This method is intended to transform the abstract tale data into a concrete [Story] instance,
  /// linking it to a specific user through the provided `userId`.
  Story toStory(String userId);
}
