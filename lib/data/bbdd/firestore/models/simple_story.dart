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
  String? imageUrl;
  @override
  String? user;
  @override
  DateTime? date;
  @override
  DocumentReference? speech;

  final String? prompt;

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

  factory Story.fromMap(Map<String, dynamic> map) {
    return Story(
      uuid: map['id'] as String?,
      title: map['title'] as String?,
      text: map['story'] as String?,
      imageUrl: map['imageUrl'] as String?,
      user: map['user'] as String?,
      prompt: map['prompt'] as String?,

      date: map['date'] != null ? DateTime.parse(map['date'] as String) : null,
      speech: map['speech']
          as DocumentReference?, // Assuming DocumentReference can be directly assigned
    );
  }
  @override
  String toString() {
    return 'Story(uuid: $uuid, title: $title, text: $text, prompt: $prompt, imageUrl: $imageUrl, user: $user, date: $date, speech: $speech)';
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
        other.prompt == prompt &&
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
        prompt.hashCode ^
        speech.hashCode;
  }
}
