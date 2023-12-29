import 'package:firestore_ref/firestore_ref.dart';

class Preprompt {
  final String? model;
  final String? system;
  final String? assistant;
  final DocumentReference? user;
  final String? uuid;

  Preprompt({this.model, this.system, this.assistant, this.user, this.uuid});

  Preprompt copyWith({
    String? model,
    String? system,
    String? assistant,
    DocumentReference? user,
    String? uuid,
  }) {
    return Preprompt(
      model: model ?? this.model,
      system: system ?? this.system,
      assistant: assistant ?? this.assistant,
      user: user ?? this.user,
      uuid: uuid ?? this.uuid,
    );
  }

  factory Preprompt.fromFirestore(Map<String, dynamic> firestoreData) {
    return Preprompt(
      model: firestoreData['model'] as String?,
      system: firestoreData['system'] as String?,
      assistant: firestoreData['assistant'] as String?,
      user: firestoreData['user'] as DocumentReference?,
      uuid: firestoreData['uuid'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'model': model,
      'system': system,
      'assistant': assistant,
      'user': user,
      'uuid': uuid,
    };
  }

  @override
  String toString() {
    return 'Preprompt(model: $model, system: $system, assistant: $assistant, user: $user, uuid: $uuid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Preprompt &&
      other.model == model &&
      other.system == system &&
      other.assistant == assistant &&
      other.user == user &&
      other.uuid == uuid;
  }

  @override
  int get hashCode {
    return model.hashCode ^
      system.hashCode ^
      assistant.hashCode ^
      user.hashCode ^
      uuid.hashCode;
  }
}
