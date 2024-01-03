import 'package:story_teller/data/bbdd/firestore/models/simple_story.dart';

abstract class AbstractFireStoreRepository {
  Future<void> uploadTale(Story story);
  Future<void> updateTale(Story story);
  Future<List<Story>> getAllTales();
  Future<Story> getTale(String id);

}
