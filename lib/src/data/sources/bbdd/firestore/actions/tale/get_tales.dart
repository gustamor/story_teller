import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/src/core/constants.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/models/simple_story.dart';
import 'package:story_teller/src/data/di/firebase_providers.dart';
import 'package:story_teller/src/domain/providers/auth_providers.dart';

/// A `StreamProvider` for fetching a list of stories from Firestore.
///
/// Retrieves story documents from the Firestore database in the user's
/// story collection. Utilizes [firebaseFirestoreProvider] for database
/// interactions and [authenticationProvider] for user authentication.
///
/// Implements a custom converter to map Firestore data to the [Story] model.
/// Each document in the stories collection is transformed into a [Story] object.
///
/// Throws an [Exception] for errors during Firestore operations.
///
/// Returns a stream of [List<Story>] representing the user's stories.
final getTalesProvider = StreamProvider<List<Story>>((ref) async* {
  // Access the Firestore database reference.
  final db = ref.read(firebaseFirestoreProvider);

  // Retrieve the ID of the currently authenticated user.
  final currentUser = await ref.read(authenticationProvider).getCurrentUser();

  try {
    // Stream Firestore snapshots, converting each to a [Story].
    yield* db
        .collection(Collections.kUsers)
        .doc(currentUser!.uid)
        .collection(Collections.kStories)
        .withConverter(
          fromFirestore: Story.fromFirestore,
          toFirestore: (Story story, _) => story.toFirestore(),
        )
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  } on FirebaseException catch (e) {
    // Handle Firebase-specific exceptions.
    throw Exception(e);
  } catch (e) {
    // Handle other exceptions.
    throw Exception(e);
  }
});
