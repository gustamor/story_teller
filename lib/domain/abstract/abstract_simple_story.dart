import 'package:cloud_firestore/cloud_firestore.dart';

/// Abstract class representing the basic structure of a story.
///
/// This class outlines the essential attributes of a story, including its title,
/// associated speech document, user information, date, UUID, image URL, and text content.
/// It provides a template for story-related operations like copying and serialization.
abstract class AbstractSimpleStory {
  /// Title of the story.
  String? get title;

  /// Reference to the speech document in Firestore.
  DocumentReference? get speech;

  /// ID of the user associated with the story.
  String? get user;

  /// Date and time when the story was created or modified.
  DateTime? get date;

  /// Unique identifier of the story.
  String? get uuid;

  /// URL of the story's associated image, if any.
  String? get imageUrl;

  /// Text content of the story.
  String? get text;

  /// Creates a copy of the story with modified attributes.
  ///
  /// Allows for creating a new instance of the story with altered fields, 
  /// leaving other fields unchanged if not specified.
  AbstractSimpleStory copyWith({
    String? title,
    DocumentReference? speech,
    String? user,
    DateTime? date,
    String? uuid,
    String? text,
  });

  /// Factory constructor to create a story instance from Firestore data.
  ///
  /// Implementations should use this method to instantiate a story object from data
  /// retrieved from Firestore. Throws [UnimplementedError] if called on the abstract class directly.
  factory AbstractSimpleStory.fromFirestore(Map<String, dynamic> firestoreData) {
    throw UnimplementedError('fromFirestore() has not been implemented.');
  }

  /// Converts the story data to a format suitable for Firestore storage.
  ///
  /// This method should be implemented to provide a map representation of the story data,
  /// typically for serialization or storage purposes in Firestore.
  Map<String, dynamic> toFirestore();

  @override
  /// Returns a string representation of the story.
  ///
  /// Useful for debugging and logging, this method provides a human-readable format of the story's data.
  String toString();

  @override
  /// Determines the equality of story instances.
  ///
  /// Two stories are considered equal if all their corresponding fields are equal.
  /// This method is useful for comparing story instances, such as in collections or when validating changes.
  bool operator ==(Object other);

  @override
  /// Generates a hash code for the story instance.
  ///
  /// This method is useful for ensuring efficient storage and retrieval of story instances
  /// in data structures that use hashing.
  int get hashCode;
}
