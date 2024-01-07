import 'package:story_teller/data/bbdd/firestore/models/simple_story.dart';

abstract class AbstractTaleData {
  String get id;
  String get title;
  String get story;
  String? get prompt;

  factory AbstractTaleData.fromMap(Map<String, dynamic> map) {
    throw UnimplementedError('fromMap() has not been implemented.');
  }

  Map<String, dynamic> toMap();

  @override
  String toString();
  
  Story toStory(String userId);
}
