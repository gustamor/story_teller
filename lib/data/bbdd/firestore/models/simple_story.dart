import 'package:firestore_ref/firestore_ref.dart';
import 'package:story_teller/domain/abstract_simple_story.dart';
class Story implements AbstractSimpleStory {
  @override
  final String? uuid;
  @override
  final String? title;
  @override
  final String? text;
  @override
  final String? imageUrl;
  @override
  final String? user;
  @override
  final DateTime? date;
  @override
  final DocumentReference? speech;

  Story({this.uuid, this.title, this.text, this.imageUrl, this.user, this.date, this.speech});

  @override
  Story copyWith({
    String? uuid,
    String? title,
    String? text,
    String? imageUrl,
    String? user,
    DateTime? date,
    DocumentReference? speech,
  }) {
    return Story(
      uuid: uuid ?? this.uuid,
      title: title ?? this.title,
      text: text ?? this.text,
      imageUrl: imageUrl ?? this.imageUrl,
      user: user ?? this.user,
      date: date ?? this.date,
      speech: speech ?? this.speech,
    );
  }

  factory Story.fromFirestore(Map<String, dynamic> firestoreData) {
    return Story(
      uuid: firestoreData['uuid'] as String?,
      title: firestoreData['title'] as String?,
      text: firestoreData['text'] as String?,
      imageUrl: firestoreData['imageUrl'] as String?,
      user: firestoreData['user'] as String?,
      date: firestoreData.containsKey('date') ? (firestoreData['date'] as Timestamp?)?.toDate() : null,
      speech: firestoreData['speech'] as DocumentReference?,
    );
  }

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

    return map;
  }

  @override
  String toString() {
    return 'Story(uuid: $uuid, title: $title, text: $text, imageUrl: $imageUrl, user: $user, date: $date, speech: $speech)';
  }

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
        other.speech == speech;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        title.hashCode ^
        text.hashCode ^
        imageUrl.hashCode ^
        user.hashCode ^
        date.hashCode ^
        speech.hashCode;
  }
}