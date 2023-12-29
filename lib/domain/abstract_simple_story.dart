import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AbstractSimpleStory {
  String? get title;
  DocumentReference? get speech; // Referencia al documento Speech
  String? get user; // ID de referencia del usuario
  DateTime? get date; // Usando DateTime para la fecha
  String? get uuid;
  String? get imageUrl;

  String? get text; // Lista de objetos Segmento

  AbstractSimpleStory copyWith({
    String? title,
    DocumentReference? speech,
    String? user,
    DateTime? date,
    String? uuid,
    String? text,
  });

  factory AbstractSimpleStory.fromFirestore(Map<String, dynamic> firestoreData) {
    throw UnimplementedError('fromFirestore() has not been implemented.');
  }

  Map<String, dynamic> toFirestore();

  @override
  String toString();

  @override
  bool operator ==(Object other);

  @override
  int get hashCode;
}