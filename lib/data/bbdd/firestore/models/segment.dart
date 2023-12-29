import 'package:firestore_ref/firestore_ref.dart';

class Segment {
  final String? text;
  final String? image; // ID de referencia de imagen
  final DocumentReference? user; // ID de referencia de autor
  final String? uuid;

  Segment({this.text, this.image, this.user, this.uuid});

  Segment copyWith({
    String? text,
    String? image,
    DocumentReference? user,
    String? uuid,
  }) {
    return Segment(
      text: text ?? this.text,
      image: image ?? this.image,
      user: user ?? this.user,
      uuid: uuid ?? this.uuid,
    );
  }

  factory Segment.fromFirestore(Map<String, dynamic> firestoreData) {
    return Segment(
      text: firestoreData['text'] as String?,
      image: firestoreData['image'] as String?,
      user: firestoreData['user'] as DocumentReference?,
      uuid: firestoreData['uuid'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'text': text,
      'image': image,
      'user': user,
      'uuid': uuid,
    };
  }

  @override
  String toString() {
    return 'Segment(text: $text, image: $image, user: $user, uuid: $uuid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Segment &&
      other.text == text &&
      other.image == image &&
      other.user == user &&
      other.uuid == uuid;
  }

  @override
  int get hashCode {
    return text.hashCode ^
      image.hashCode ^
      user.hashCode ^
      uuid.hashCode;
  }
}
