import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/constants.dart';
import 'package:story_teller/data/api/model/tale_data.dart';
import 'package:story_teller/data/bbdd/firestore/models/simple_story.dart';
import 'package:story_teller/di/firebase_providers.dart';
import 'package:story_teller/domain/providers/auth_providers.dart';

final uploadTaleProvider =
    FutureProvider.family<void, TaleData>((ref, taleData) async {
  final db = ref.read(firebaseFirestoreProvider);
  final currentUser = await ref.read(authenticationProvider).getCurrentUser();
  try {
    final collectionRef = db
        .collection(Collections.kUsers)
        .doc(currentUser!.uid)
        .collection(Collections.kStories)
        .withConverter(
          fromFirestore: Story.fromFirestore,
          toFirestore: (Story story, _) => story.toFirestore(),
        );
    final docRef = collectionRef.doc(taleData.id);
    final tale = taleData.toMap();
    Story story = Story.fromMap(tale);
    story.date = DateTime.now();
    story.user = currentUser.uid;

    docRef.set(story, SetOptions(merge: true));
  } on FirebaseException catch (e) {
    print("Error uploading story to Firebase: $e");
    throw Exception(e);
  } catch (e) {
    throw Exception(e);
  }
});
