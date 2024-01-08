

import 'package:story_teller/src/data/sources/bbdd/firestore/models/simple_story.dart';
import 'package:story_teller/src/domain/abstract/abstract_firestore_repository.dart';

class FirestoreRepository implements AbstractFireStoreRepository {
  @override
  Future<List<Story>> getAllTales() {
     // TODO: implement getAllTales
    throw UnimplementedError();
  }

  @override
  Future<Story> getTale(String id) {
    // TODO: implement getTale
    throw UnimplementedError();
  }

  @override
  Future<void> updateTale(Story story) {
    // TODO: implement updateTale
    throw UnimplementedError();
  }

  @override
  Future<void> uploadTale(Story story) {
    // TODO: implement uploadTale
    throw UnimplementedError();
  }

}