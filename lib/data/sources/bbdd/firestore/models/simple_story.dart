import 'package:firestore_ref/firestore_ref.dart';
import 'package:story_teller/domain/abstract/abstract_simple_story.dart';
/// Represents a story with various attributes and provides methods for data manipulation and Firestore interaction.
///
/// This class encapsulates attributes such as unique identifier, title, text content, image URL, associated user,
/// date, speech reference, and an optional prompt. It also provides methods for creating copies of the story with 
/// modified attributes, constructing a story instance from Firestore data, converting the story to a Firestore-compatible
/// format, and standard object methods like `toString`, equality comparison, and hash code generation.
class Story implements AbstractSimpleStory {
  /// The unique identifier of the story.
  @override
  final String? uuid;

  /// The title of the story.
  @override
  final String? title;

  /// The text content of the story.
  @override
  final String? text;

  /// The URL of the image associated with the story.
  @override
  String? imageUrl;

  /// The identifier of the user associated with the story.
  @override
  String? user;

  /// The date when the story was created or last updated.
  @override
  DateTime? date;

  /// A reference to the speech model associated with the story.
  @override
  DocumentReference? speech;

  /// An optional prompt that may be associated with the story.
  final String? prompt;

  /// Constructs a new `Story` instance with the specified attributes.
  Story({
      this.uuid,
      this.title,
      this.text,
      this.imageUrl,
      this.user,
      this.date,
      this.speech,
      this.prompt});

  /// Creates a copy of this story with the given parameters, allowing for modification of
  /// any number of fields while preserving the original story's values for unchanged fields.
  Story copyWith({
    String? uuid,
    String? title,
    String? text,
    String? imageUrl,
    String? user,
    DateTime? date,
    DocumentReference? speech,
    String? prompt,
  }) {
    return Story(
      uuid: uuid ?? this.uuid,
      title: title ?? this.title,
      text: text ?? this.text,
      imageUrl: imageUrl ?? this.imageUrl,
      user: user ?? this.user,
      date: date ?? this.date,
      speech: speech ?? this.speech,
      prompt: prompt ?? this.prompt,
    );
  }

  /// Creates a `Story` instance from Firestore data.
  ///
  /// Extracts data fields from a [DocumentSnapshot] and handles data type conversions,
  /// facilitating the creation of a `Story` instance directly from Firestore query results.
  factory Story.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final firestoreData = snapshot.data();
    return Story(
        uuid: firestoreData?['uuid'] as String?,
        title: firestoreData?['title'] as String?,
        text: firestoreData?['text'] as String?,
        imageUrl: firestoreData?['imageUrl'] as String?,
        user: firestoreData?['user'] as String?,
        date: firestoreData!.containsKey('date')
            ? (firestoreData['date'] as Timestamp?)?.toDate()
            : null,
        speech: firestoreData['speech'] as DocumentReference?,
        prompt: firestoreData['prompt'] as String?);
  }

  /// Converts the `Story` instance to a `Map<String, dynamic>` format suitable for Firestore storage.
  ///
  /// Formats the story attributes into a map structure, ensuring only non-null fields are included,
  /// making it suitable for Firestore storage or other forms of serialization where null values are to be omitted.
  @override
  Map<String, dynamic> toFirestore() {
    final map = <String, dynamic>{};
    if (uuid != null) map['uuid'] = uuid;
    if (title != null) map['title'] = title;
    if (text != null) map['text'] = text;
    if (imageUrl != null) map['imageUrl'] = imageUrl;
    if (user != null) map['user'] = user;
    if (date != null) map['date'] = Timestamp.fromDate(date!);
    if (speech != null) map['speech'] = speech;
    if (prompt != null) map['prompt'] = prompt;

    return map;
  }

  /// Creates a `Story` instance from a map structure.
  ///
  /// Useful for constructing a `Story` instance from a map, typically when retrieving data from a database or
  /// a service that returns data in a map format. Ensures proper type conversion and handling of optional fields.
  factory Story.fromMap(Map<String, dynamic> map) {
    return Story(
      uuid: map['id'] as String?,
      title: map['title'] as String?,
      text: map['story'] as String?,
      imageUrl: map['imageUrl'] as String?,
      user: map['user'] as String?,
      prompt: map['prompt'] as String?,

      date: map['date'] != null ? DateTime.parse(map['date'] as String) : null,
      speech: map['speech'] as DocumentReference?, // Assuming DocumentReference can be directly assigned
    );
  }

  /// Returns a string representation of the story, including all its fields.
  /// Useful for debugging and logging purposes.
  @override
  String toString() {
    return 'Story(uuid: $uuid, title: $title, text: $text, imageUrl: $imageUrl, user: $user, date: $date, speech: $speech, prompt: $prompt)';
  }

  /// Determines the equality of `Story` instances.
  ///
  /// Considers two instances equal if all their corresponding fields are equal. 
  /// Useful in scenarios where story instances need to be compared, such as in collections or when validating changes.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Story &&
        other.uuid == uuid &&
        other.title == title &&
        other.text == text &&
        other.imageUrl == imageUrl &&
        other.user == user &&
        other.date == date &&
        other.prompt == prompt &&
        other.speech == speech;
  }

  /// Generates a hash code for the `Story` instance.
  ///
  /// Useful for efficient storage and retrieval of `Story` instances in data structures that use hashing,
  /// such as hash tables. The hash code is computed based on all the fields of the story.
  @override
  int get hashCode {
    return uuid.hashCode ^
        title.hashCode ^
        text.hashCode ^
        imageUrl.hashCode ^
        user.hashCode ^
        date.hashCode ^
        prompt.hashCode ^
        speech.hashCode;
  }
}
