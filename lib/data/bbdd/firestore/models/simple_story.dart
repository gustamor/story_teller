import 'package:firestore_ref/firestore_ref.dart';
import 'package:story_teller/domain/abstract_simple_story.dart';

/// A representation of a story, implementing the `AbstractSimpleStory` interface.
/// 
/// This class encapsulates various attributes of a story, such as its unique identifier,
/// title, text content, image URL, associated user, date, speech reference, and an optional
/// prompt. It provides methods for creating copies of the story with modified attributes,
/// constructing a story instance from Firestore data, converting the story to a Firestore-compatible
/// format, and standard object methods like `toString`, equality comparison, and hash code generation.
class Story implements AbstractSimpleStory {
  @override
  final String? uuid;

  @override
  final String? title;

  @override
  final String? text;

  @override
  String? imageUrl;

  @override
  String? user;

  @override
  DateTime? date;

  @override
  DocumentReference? speech;

  /// An optional prompt associated with the story.
  final String? prompt;

  /// Constructs a new `Story` instance with the specified attributes.
  Story(
      {this.uuid,
      this.title,
      this.text,
      this.imageUrl,
      this.user,
      this.date,
      this.speech,
      this.prompt});

  @override
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

  /// Factory constructor to create a `Story` instance from Firestore data.
  /// It extracts data fields from a [DocumentSnapshot] and handles data type conversions.
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

  @override
  /// Converts the story to a `Map<String, dynamic>` format suitable for Firestore storage.
  /// Only non-null fields are included in the map.
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

  /// Factory constructor to create a `Story` instance from a map structure, typically used when
  /// retrieving data from a database or a service that returns data in a map format.
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

  @override
  /// Determines the equality of `Story` instances.
  /// 
  /// Two instances are considered equal if all their corresponding fields are equal. 
  /// This method is useful in scenarios where story instances need to be compared, 
  /// such as in collections or when validating changes.
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

  @override
  /// Generates a hash code for the `Story` instance.
  /// 
  /// This method is useful for ensuring efficient storage and retrieval of `Story` instances 
  /// in data structures that use hashing, such as hash tables. The hash code is derived 
  /// from all the fields of the story.
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
